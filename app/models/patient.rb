class Patient < ApplicationRecord
  # Relaciones
  belongs_to :marital_status
  belongs_to :education_level
  belongs_to :insurer

  # Enums
  enum :gender, [ :masculino, :femenino ], default: :masculino
  enum :interrogation, [ :directo, :indirecto ], default: :directo

  # Validaciones
  validates :name, :last_name, :second_last_name, :birth_date, :phone_number, :email, :gender,
    presence: true
  validates :email, presence: true, uniqueness: true,
  format: {
    with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}\z/,
    message: 'debe ser un correo electrónico válido'
  }
  validates :phone_number, format: { with: /\A\d{10}\z/, message: 'deben ser 10 dígitos' }
  validates :gender, inclusion: { in: genders.keys }
  validates :interrogation, inclusion: { in: interrogations.keys }, allow_nil: true
  validate :birth_date_must_be_valid

private
  def birth_date_must_be_valid
    if birth_date.present?
      if birth_date > Time.now
        errors.add(:birth_date, 'debe ser en el pasado')
      elsif birth_date < Time.now - 120.years
        errors.add(:birth_date, 'debe ser mas reciente')
      end
    end
  end
end
