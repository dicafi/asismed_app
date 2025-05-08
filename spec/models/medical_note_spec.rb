require 'rails_helper'

RSpec.describe MedicalNote, type: :model do
  describe 'associations' do
    it { should belong_to(:appointment) }
    # it { should have_many(:note_diagnostics).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:appointment) }

    it { should allow_value('120/80').for(:ta) }
    it { should_not allow_value('invalid').for(:ta) }
    it { should_not allow_value('120-80').for(:ta) }

    it { should allow_value('98').for(:spo2) }
    it { should_not allow_value('98%').for(:spo2) }
    it { should_not allow_value('invalid').for(:spo2) }

    it { should allow_value(36.5).for(:temperature) }
    it { should_not allow_value(10).for(:temperature) } # Menor al rango permitido
    it { should_not allow_value(60).for(:temperature) } # Mayor al rango permitido

    it { should allow_value(90.0).for(:glucose) }
    it { should_not allow_value(-10).for(:glucose) } # Valor negativo no permitido

    it { should allow_value(18.0).for(:fr) }
    it { should_not allow_value(-5).for(:fr) } # Valor negativo no permitido

    it { should allow_value(72.0).for(:fc) }
    it { should_not allow_value(0).for(:fc) } # Valor igual a 0 no permitido

    it { should allow_value(70.5).for(:weight) }
    it { should_not allow_value(-1).for(:weight) } # Valor negativo no permitido

    it { should allow_value(1.75).for(:height) }
    it { should_not allow_value(0).for(:height) } # Valor igual a 0 no permitido
  end
end
