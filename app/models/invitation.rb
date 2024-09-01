class Invitation < ApplicationRecord
  validates :inviter_id, presence: true
  validates :role_id, presence: true
  validates :code, presence: true, uniqueness: true
  validates :invitee_name, presence: true
end
