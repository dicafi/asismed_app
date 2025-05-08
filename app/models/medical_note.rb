class MedicalNote < ApplicationRecord
  # Relaciones
  belongs_to :appointment
  # has_many :note_diagnostics, dependent: :destroy

  # Validaciones
  validates :appointment, presence: true
  validates :ta, format: { with: /\A\d{2,3}\/\d{2,3}\z/, message: 'debe tener el formato 120/80' },
    allow_nil: true
  validates :spo2, format: { with: /\A\d{2,3}\z/, message: 'debe tener el formato 98' },
    allow_nil: true
  validates :temperature, numericality: { greater_than_or_equal_to: 20, less_than_or_equal_to: 50 },
    allow_nil: true
  validates :glucose, :fr, :fc, :weight, :height, numericality: { greater_than: 0 }, allow_nil: true
end
