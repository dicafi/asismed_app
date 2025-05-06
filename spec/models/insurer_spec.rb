require 'rails_helper'

RSpec.describe Insurer, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:description) }
    it { should validate_uniqueness_of(:description) }
  end
end
