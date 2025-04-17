class User < ApplicationRecord
  has_secure_password

  validates :password, presence: true, length: { minimum: 8 },
    if: -> { new_record? || !password.nil? }
  validates :password_confirmation, presence: true, if: -> { new_record? || !password.nil? }

  # Validación opcional para complejidad de la contraseña
  validates :password, format: {
    with: /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}\z/,
    message: <<~TEXT
      must include at least one uppercase letter, one lowercase letter, one number,
      and one special character
    TEXT
  }, if: -> { password.present? }

  validates :username, presence: true, uniqueness: true,
    format: {
      with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}\z/,
      message: 'must be a valid email address'
    }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone_number,
    format: { with: /\A\+?[0-9\s\-()]+\z/, message: 'only allows valid phone numbers' }

  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }

  def full_name
    "#{first_name} #{last_name} #{second_last_name}"
  end

  def deactivate
    update(active: false)
  end

  def activate
    update(active: true)
  end
end
