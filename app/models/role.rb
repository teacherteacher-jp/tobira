class Role < ApplicationRecord
  has_many :role_channels, dependent: :destroy
  has_many :channels, through: :role_channels

  validates :original_id, presence: true
  validates :name, presence: true

  scope :usable, -> { where(usable: true) }

  class << self
    def sync_with_server
      roles = Discord::Bot.new.roles

      roles_without_bot = roles.reject {
        _1.dig("tags", "bot_id") ||
        _1.dig("name") == "@everyone" ||
        _1.dig("name") == "Server Booster"
      }

      roles_without_bot.each do |role|
        r = Role.find_or_initialize_by(original_id: role["id"])
        r.name = role["name"]
        r.save
      end

      Role.where.not(original_id: roles_without_bot.map { _1.dig("id") }).destroy_all
    end
  end

  def channel
    channels.first
  end
end
