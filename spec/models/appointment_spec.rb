require 'rails_helper'

RSpec.describe Appointment, type: :model do
  subject { appointment }

  let(:appointment) { Appointment.new(appointment_atts) }
  let(:patient) { create(:patient) }
  let(:doctor) { create(:user) }
  let(:medical_note) { create(:medical_note) }
  let(:date) { Date.today }
  let(:time) { Time.now }
  let(:appointment_atts) do
    {
      date: date,
      time: time,
      patient: patient,
      doctor: doctor,
      medical_note: medical_note
    }
  end

  describe 'validations' do
    it { should validate_presence_of(:date) }
    it { should validate_presence_of(:time) }
    it { should validate_presence_of(:doctor) }
    it { should validate_presence_of(:patient) }

    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    context 'without a date' do
      let(:date) { nil }

      it 'is invalid' do
        expect(subject).not_to be_valid
        expect(subject.errors[:date]).to include("can't be blank")
      end
    end

    context 'without a time' do
      let(:time) { nil }

      it 'is invalid' do
        expect(subject).not_to be_valid
        expect(subject.errors[:time]).to include("can't be blank")
      end
    end

    context 'without a doctor' do
      let(:doctor) { nil }

      it 'is invalid' do
        expect(subject).not_to be_valid
        expect(subject.errors[:doctor]).to include("can't be blank")
      end
    end

    context 'without a patient' do
      let(:patient) { nil }

      it 'is invalid' do
        expect(subject).to_not be_valid
        expect(subject.errors[:patient]).to include("can't be blank")
      end
    end

    context 'without a medical note' do
      let(:medical_note) { nil }

      it { expect(subject).to be_valid  }
    end
  end

  describe 'associations' do
    it { should belong_to(:patient) }
    it { should belong_to(:doctor).class_name('User') }
    it { should belong_to(:medical_note).optional }
  end

  describe '#date_cannot_be_in_the_past' do
    context 'when the date is in the past' do
      let(:date) { 2.days.ago }

      it 'is not valid' do
        expect(subject).not_to be_valid
        expect(subject.errors[:date]).to include("can't be in the past")
      end
    end

    context 'when the date is today' do
      let(:date) { Date.today }

      it { expect(subject).to be_valid }
    end

    context 'when the date is in the future' do
      let(:date) { Date.tomorrow }

      it { expect(subject).to be_valid }
    end
  end
end
