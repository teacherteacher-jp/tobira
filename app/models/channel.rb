class Channel < ApplicationRecord
  belongs_to :category, class_name: "Channel", foreign_key: :category_id, primary_key: :original_id, optional: true

  validates :original_id, presence: true
  validates :name, presence: true
  validates :type_id, presence: true
  validates :position, presence: true

  # https://discord.com/developers/docs/resources/channel#channel-object-channel-types
  enum :type_id, {
    text: 0,
    voice: 2,
    category: 4,
    announcement: 5,
    stage: 13,
    forum: 15
  }

  class << self
    def sync_with_server
      channels = Discord::Bot.new.channels

      channels.each do |channel|
        Channel.find_or_create_by(original_id: channel.dig("id")) do |c|
          c.name = channel.dig("name")
          c.type_id = channel.dig("type")
          c.category_id = channel.dig("parent_id")
          c.position = channel.dig("position")
        end
      end

      Channel.where.not(original_id: channels.map { _1.dig("id") }).destroy_all
    end
  end

  def name_with_category
    category ? "[#{category.name}] #{name}" : name
  end
end
