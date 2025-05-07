require 'rails_helper'

RSpec.describe MaritalStatus, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:description) }
    it { should validate_uniqueness_of(:description) }
  end

  describe 'associations' do
    it { should have_many(:patients) }
  end
end
