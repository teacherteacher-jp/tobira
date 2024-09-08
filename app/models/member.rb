class Member < ApplicationRecord
  has_many :invitations, foreign_key: :inviter_id

  validates :name, presence: true, length: { maximum: 32 }
  validates :discord_uid, uniqueness: true, presence: true, length: { maximum: 32 }
end
