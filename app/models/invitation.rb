class Invitation < ApplicationRecord
  belongs_to :inviter, class_name: "Member", foreign_key: :inviter_id
  belongs_to :role

  validates :inviter_id, presence: true
  validates :role_id, presence: true
  validates :code, presence: true, uniqueness: true, format: { with: /\ATT-[A-Z0-9]{6}\z/ }
  validates :invitee_name, presence: true

  before_validation :set_code
  before_validation :strip_invitee_name
  after_create :notify_to_discord_admin

  class << self
    def generate_code
      characters = ("A".."Z").to_a + ("0".."9").to_a
      "TT-" + 6.times.map { characters.sample }.join
    end
  end

  def guide_text
    <<~TEXT
      (あとで実装します)
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
        #{inviter.name}が「#{invitee_name}」を「#{role.name}」として招待するためのコードを発行しました :ticket:
      CONTENT
    )
  end
end
