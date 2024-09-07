class Member < ApplicationRecord
  validates :name, presence: true, length: { maximum: 32 }
  validates :discord_uid, uniqueness: true, presence: true, length: { maximum: 32 }
end
