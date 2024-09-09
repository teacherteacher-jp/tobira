class Invitations::AcceptanceController < ApplicationController
  def create
    invitation = Invitation.not_used.find_by(code: params[:code].to_s.strip)

    if invitation
      invitation.used_by!(current_member)
      redirect_to(root_path, notice: "Discordサーバに招待しました！")
    else
      redirect_to(root_path, notice: "招待コードが無効のようです。管理者に問い合わせてください。")
    end
  end
end
