class SessionsController < ActionController::Base
  include SessionHelper

  def create
    auth_hash = request.env["omniauth.auth"]
    pp auth_hash

    uid = auth_hash.dig("uid")
    name = auth_hash.dig("info", "name")
    icon_url = auth_hash.dig("info", "image")

    member = Member.find_or_initialize_by(discord_uid: uid)
    member.update(name:, icon_url:)

    log_in(member)

    redirect_to root_path
  end

  def destroy
    log_out
    redirect_to gate_path
  end
end
