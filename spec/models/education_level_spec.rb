require 'rails_helper'

RSpec.describe EducationLevel, type: :model do
  describe '.all' do
    it 'returns all education levels as a hash' do
      levels = EducationLevel.all

      expect(levels).to be_a(Hash)
      expect(levels.keys).to match_array([ 0, 1, 2, 3, 4, 5, 6, 7 ])
      expect(levels[0][:description]).to eq('No Aplica')
      expect(levels[7][:description]).to eq('Doctorado')
    end
  end

  describe 'LEVELS constant' do
    it 'is frozen to prevent modifications' do
      expect(EducationLevel::LEVELS).to be_frozen
    end

    it 'contains unique IDs' do
      ids = EducationLevel::LEVELS.keys
      expect(ids).to eq(ids.uniq)
    end

    it 'contains valid descriptions for each level' do
      EducationLevel::LEVELS.each do |id, level|
        expect(level).to have_key(:description)
        expect(level[:description]).to be_a(String)
        expect(level[:description]).not_to be_empty
      end
    end
  end
end
