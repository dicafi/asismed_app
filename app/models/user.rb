class User < ApplicationRecord
  has_secure_password
  before_update :invalidate_session_token, if: :password_digest_changed?

  has_many :appointments, foreign_key: 'doctor_id'

  validates :password, presence: true, length: { minimum: 8 },
    if: -> { new_record? || !password.nil? }
  validates :password_confirmation, presence: true, if: -> { new_record? || !password.nil? }

  # Validación opcional para complejidad de la contraseña
  validates :password, format: {
    with: /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}\z/,
    message: 'must include at least one uppercase letter, one lowercase letter, one number, ' +
      'and one special character'
  }, if: -> { password.present? }

  validates :username, presence: true, uniqueness: true,
    format: {
      with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}\z/,
      message: 'must be a valid email address'
    }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone_number,
    format: { with: /\A\+?\d{10}\z/, message: 'must be exactly 10 digits' },
    allow_blank: true
  validates :office, presence: true

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

private
  def invalidate_session_token
    self.session_token = nil
  end
end
