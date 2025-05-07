require 'rails_helper'

RSpec.describe Patient, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:second_last_name) }
    it { should validate_presence_of(:birth_date) }
    it { should validate_presence_of(:phone_number) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:gender) }

    it { should allow_value('test@example.com').for(:email) }
    it { should_not allow_value('invalid_email').for(:email) }

    it { should allow_value('1234567890').for(:phone_number) }
    it { should_not allow_value('12345').for(:phone_number) }

    it { should define_enum_for(:gender).with_values(masculino: 0, femenino: 1) }
    it { should define_enum_for(:interrogation).with_values(directo: 0, indirecto: 1) }

    context 'birth_date' do
      let(:education_level) { create(:education_level) }
      let(:marital_status) { create(:marital_status) }
      let(:insurer) { create(:insurer) }

      it 'is invalid if the birth_date is more than 120 years ago' do
        patient = build(:patient, birth_date: Time.now - 121.years,
          education_level: education_level, marital_status: marital_status, insurer: insurer)

        expect(patient).not_to be_valid
        expect(patient.errors[:birth_date]).to include('debe ser mas reciente')
      end

      it 'is valid if the birth_date is within the last 120 years' do
        patient = build(:patient, birth_date: Time.now - 100.years,
          education_level: education_level, marital_status: marital_status, insurer: insurer)

        expect(patient).to be_valid
      end

      it 'is invalid if the birth_date is in the future' do
        patient = build(:patient, birth_date: Time.now + 2.days,
          education_level: education_level, marital_status: marital_status, insurer: insurer)

        expect(patient).not_to be_valid
        expect(patient.errors[:birth_date]).to include('debe ser en el pasado')
      end
    end
  end

  describe 'associations' do
    it { should belong_to(:marital_status) }
    it { should belong_to(:education_level) }
    it { should belong_to(:insurer) }
  end
end
