class SessionsController < ActionController::Base
  include SessionHelper

  def create
    auth_hash = request.env["omniauth.auth"]
    pp auth_hash

    uid = auth_hash.dig("uid")
    name = auth_hash.dig("info", "name")

    member = Member.find_or_initialize_by(discord_uid: uid)
    member.update(name:)

    log_in(member)

    redirect_to root_path
  end

  def destroy
    log_out
    redirect_to gate_path
  end
end
