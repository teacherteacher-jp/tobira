class Role < ApplicationRecord
  validates :original_id, presence: true
  validates :name, presence: true
end
