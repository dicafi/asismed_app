class Diagnostic < ApplicationRecord
  # Validaciones
  validates :key, presence: true, uniqueness: true,
    format: { with: /\A[a-zA-Z0-9]+\z/, message: 'solo permite caracteres alfanuméricos' }
  validates :description, presence: true
end
