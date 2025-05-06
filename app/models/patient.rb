class Patient < ApplicationRecord
  # validates :education_level_id, inclusion: { in: EducationLevel.all.map { |level| level[:id] } }
end
