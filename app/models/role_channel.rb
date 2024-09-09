class RoleChannel < ApplicationRecord
  belongs_to :role
  belongs_to :channel

  validates :role_id, presence: true
  validates :channel_id, presence: true
end
