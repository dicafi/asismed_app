class Insurer < ApplicationRecord
  validates :description, presence: true, uniqueness: true
end
