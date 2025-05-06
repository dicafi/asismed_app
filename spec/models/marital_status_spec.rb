require 'rails_helper'

RSpec.describe MaritalStatus, type: :model do
  describe '.all' do
    it 'returns all marital statuses as a hash' do
      statuses = MaritalStatus.all

      expect(statuses).to be_a(Hash)
      expect(statuses.keys).to match_array([ 0, 1, 2, 3, 4, 5 ])
      expect(statuses[0][:description]).to eq('Soltero(a)')
      expect(statuses[4][:description]).to eq('Concubinato')
    end
  end

  describe 'STATUSES constant' do
    it 'is frozen to prevent modifications' do
      expect(MaritalStatus::STATUSES).to be_frozen
    end

    it 'contains unique IDs' do
      ids = MaritalStatus::STATUSES.keys
      expect(ids).to eq(ids.uniq)
    end

    it 'contains valid descriptions for each status' do
      MaritalStatus::STATUSES.each do |id, status|
        expect(status).to have_key(:description)
        expect(status[:description]).to be_a(String)
        expect(status[:description]).not_to be_empty
      end
    end
  end
end
