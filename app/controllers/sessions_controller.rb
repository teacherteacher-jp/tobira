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

  def failure
    error_type = request.env["omniauth.error.type"] || params[:message]

    error_message = case error_type.to_s
    when "access_denied"
      "Discordでの認証が拒否されました。Discordアカウントのメールアドレスまたは電話番号の確認が済んでいない場合は、先にDiscordの設定で確認を完了してください。"
    else
      "Discordでのログインに失敗しました。時間をおいて再度お試しください。"
    end

    redirect_to login_path, alert: error_message
  end
end
