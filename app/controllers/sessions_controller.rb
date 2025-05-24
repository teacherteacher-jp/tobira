class SessionsController < ActionController::Base
  include SessionHelper

  def create
    auth_hash = request.env["omniauth.auth"]
    pp auth_hash

    uid = auth_hash.dig("uid")
    name = auth_hash.dig("info", "name")
    access_token = auth_hash.dig("credentials", "token")

    member = Member.find_or_initialize_by(discord_uid: uid)
    member.update(name:, access_token:)

    log_in(member)

    # return_toパラメータがある場合はそちらにリダイレクト
    return_to = session[:return_to] || params[:return_to] || root_path
    session.delete(:return_to)
    redirect_to return_to
  end

  def destroy
    log_out
    redirect_to gate_path
  end
end
