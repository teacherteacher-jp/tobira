class StepsController < ApplicationController
  skip_before_action :gate_check, only: [:step0, :step1, :step2]
  before_action :set_invitation_by_code
  before_action :ensure_logged_in, only: [:step3]

  def step0
    notify_progress("「#{@invitation.invitee_name}」さんがステップ0「ご案内」にアクセスしました")
  end

  def step1
    notify_progress("「#{@invitation.invitee_name}」さんがステップ1「Discordアカウントを準備しよう」にアクセスしました")
  end

  def step2
    notify_progress("「#{@invitation.invitee_name}」さんがステップ2「Discord認証しよう」にアクセスしました")
    session[:return_to] = "/step3?code=#{@code}"
  end

  def step3
    notify_progress("「#{@invitation.invitee_name}」さんがステップ3「招待完了まであと一歩」にアクセスしました")
  end

  private

  def set_invitation_by_code
    code = params[:code].to_s.strip
    @invitation = Invitation.find_by(code: code)

    if @invitation.nil?
      redirect_to gate_path, notice: "招待コード「#{code}」は無効です。管理者に問い合わせてください。"
      notify_progress("無効な招待コード「#{code}」が入力されました")
      return
    end

    if @invitation.used?
      redirect_to gate_path, notice: "招待コード「#{code}」は使用済みです。Discordサーバに参加できているかご確認ください。"
      notify_progress("使用済みの招待コード「#{code}」が入力されました")
      return
    end

    @code = code
  end

  def ensure_logged_in
    unless logged_in?
      session[:return_to] = "/step3?code=#{@code}"
      redirect_to "/step2?code=#{@code}", notice: "Discordアカウントで認証してください。"
    end
  end

  def notify_progress(message)
    Discord::Bot.new.send_message(
      channel_or_thread_id: Rails.application.credentials.discord.admin_channel_id,
      content: "#{message} :information_source:"
    )
  rescue => e
    Rails.logger.error "Discord通知エラー: #{e.message}"
  end
end
