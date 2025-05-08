require 'rails_helper'

RSpec.describe Diagnostic, type: :model do
  describe 'validations' do
    subject { create(:diagnostic) } # Crea un registro válido antes de la prueba

    it { should validate_presence_of(:key) }
    it { should validate_uniqueness_of(:key) }
    it { should allow_value('A123').for(:key) }
    it { should_not allow_value('A123!').for(:key) }
    it { should validate_presence_of(:description) }
  end
end
