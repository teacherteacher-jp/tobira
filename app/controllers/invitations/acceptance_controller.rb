class Invitations::AcceptanceController < ApplicationController
  def create
    code = params[:code].to_s.strip
    invitation = Invitation.find_by(code:)

    if invitation.nil?
      redirect_to(root_path, notice: "招待コード「#{code}」は無効です。管理者に問い合わせてください。")
    elsif invitation.used?
      redirect_to(root_path, notice: "招待コード「#{code}」は使用済みです。Discordサーバーに参加できているかご確認ください。")
    else
      invitation.used_by!(current_member)
      redirect_to(root_path, notice: "Discordサーバに招待しました！")
    end
  end
end
