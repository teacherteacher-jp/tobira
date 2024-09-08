class Invitation < ApplicationRecord
  belongs_to :inviter, class_name: "Member", foreign_key: :inviter_id

  validates :inviter_id, presence: true
  validates :role_id, presence: true
  validates :code, presence: true, uniqueness: true, format: { with: /\ATT-[A-Z0-9]{6}\z/ }
  validates :invitee_name, presence: true

  before_validation :set_code
  before_validation :strip_invitee_name

  class << self
    def generate_code
      characters = ('A'..'Z').to_a + ('0'..'9').to_a
      "TT-" + 6.times.map { characters.sample }.join
    end
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
end
