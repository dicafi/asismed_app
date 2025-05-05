class Appointment < ApplicationRecord
  belongs_to :patient
  belongs_to :doctor, class_name: 'User'
  belongs_to :medical_note, optional: true

  validates :date, :time, :patient, :doctor, presence: true
  validate :date_cannot_be_in_the_past

private
  def date_cannot_be_in_the_past
    errors.add(:date, "can't be in the past") if date.present? && date < Date.today
  end
end
