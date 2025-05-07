class EducationLevel < ApplicationRecord
  validates :description, presence: true, uniqueness: true
  has_many :patients
end
