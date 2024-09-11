class Invitation < ApplicationRecord
  belongs_to :inviter, class_name: "Member", foreign_key: :inviter_id
  belongs_to :invitee, class_name: "Member", foreign_key: :invitee_id, optional: true
  belongs_to :role

  validates :inviter_id, presence: true
  validates :role_id, presence: true
  validates :code, presence: true, uniqueness: true, format: { with: /\ATT-[A-Z0-9]{6}\z/ }
  validates :invitee_name, presence: true

  before_validation :set_code
  before_validation :strip_invitee_name
  after_create :notify_to_discord_admin

  scope :not_used, -> { where(used_at: nil) }

  class << self
    def generate_code
      characters = ("A".."Z").to_a + ("0".."9").to_a
      "TT-" + 6.times.map { characters.sample }.join
    end
  end

  def used_by!(member)
    bot = Discord::Bot.new
    result = bot.invite(user_id: member.discord_uid, user_token: member.access_token)
    pp result

    if result.status == 201
      pp bot.add_role(user_id: member.discord_uid, role_id: role.original_id)

      pp bot.send_message(
        channel_or_thread_id: Rails.application.credentials.discord.admin_channel_id,
        content: <<~CONTENT,
          「#{invitee_name}」さん <@!#{member.discord_uid}> に「#{role.name}」を付与しました :dart:
        CONTENT
        allowed_mentions: { parse: [ "users" ] },
      )

      if role.channel
        pp bot.send_message(
          channel_or_thread_id: role.channel.original_id,
          content: <<~CONTENT,
            <@!#{member.discord_uid}> さんがやってきました、ようこそ〜！:clap:
          CONTENT
          allowed_mentions: { parse: [ "users" ] },
        )
      end

      update!(used_at: Time.current, invitee_id: member.id)
    else
    end
  end

  def guide_text
    <<~TEXT
      以下の手順に従って、Discordのコミュニティにご参加ください。

      1. Discordのアカウントを用意する
      2. #{Rails.application.credentials.app.url} にログインする
      3. 招待コード #{code} を入力する
    TEXT
  end

  def set_code
    return if code.present?

    new_code = Invitation.generate_code
    while Invitation.where(code: new_code).exists?
      new_code = Invitation.generate_code
    end
    self.code = new_code
  end

  def strip_invitee_name
    self.invitee_name = invitee_name.strip
  end

  def notify_to_discord_admin
    Discord::Bot.new.send_message(
      channel_or_thread_id: Rails.application.credentials.discord.admin_channel_id,
      content: <<~CONTENT
        #{inviter.name}が「#{invitee_name}」さんを「#{role.name}」として招待するためのコードを発行しました :ticket:
      CONTENT
    )
  end
end
