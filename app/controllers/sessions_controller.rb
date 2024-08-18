class SessionsController < ApplicationController
  def create
    auth_hash = request.env["omniauth.auth"]
    pp auth_hash

    uid = auth_hash.dig("uid")
    name = auth_hash.dig("info", "name")
    icon_url = auth_hash.dig("info", "image")

    member = Member.find_or_initialize_by(discord_uid: uid)
    member.update(name:, icon_url:)

    log_in(member)

    redirect_to root_path, notice: "ようこそ、#{name}さん！"
  end

  def destroy
    log_out
    redirect_to root_path, notice: "ログアウトしました"
  end
end
