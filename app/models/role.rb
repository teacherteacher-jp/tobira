class Role < ApplicationRecord
  validates :original_id, presence: true
  validates :name, presence: true

  class << self
    def sync_with_server
      roles = Discord::Bot.new.roles

      roles_without_bot = roles.reject {
        _1.dig("tags", "bot_id") ||
        _1.dig("name") == "@everyone" ||
        _1.dig("name") == "Server Booster"
      }

      roles_without_bot.each do |role|
        Role.find_or_create_by(original_id: role["id"]) do |r|
          r.name = role["name"]
        end
      end

      Role.where.not(original_id: roles_without_bot.map { _1.dig("id") }).destroy_all
    end
  end
end
