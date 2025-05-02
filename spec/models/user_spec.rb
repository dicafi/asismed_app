require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:user) }
  let(:user) { create(:user) }

  describe 'validations' do
    it { should validate_presence_of(:username) }
    it { should allow_value('test@example.com').for(:username) }
    it { should_not allow_value('invalid_email').for(:username) }

    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }

    it { should validate_length_of(:password).is_at_least(8).on(:create) }
    it { should validate_presence_of(:password_confirmation).on(:create) }
    it { should validate_confirmation_of(:password).on(:create) }

    it 'validates password complexity' do
      user.password = 'simple'
      user.password_confirmation = 'simple'
      expect(user).not_to be_valid
      expect(user.errors[:password]).to include('must include at least one uppercase letter, ' +
        'one lowercase letter, one number, and one special character')

      user.password = 'simple123'
      user.password_confirmation = 'simple123'
      expect(user).not_to be_valid
      expect(user.errors[:password]).to include('must include at least one uppercase letter, ' +
        'one lowercase letter, one number, and one special character')

      user.password = 'Complex123'
      user.password_confirmation = 'Complex123'
      expect(user).not_to be_valid
      expect(user.errors[:password]).to include('must include at least one uppercase letter, ' +
        'one lowercase letter, one number, and one special character')
    end

    it 'allows valid phone numbers' do
      user.phone_number = '5555555555'
      expect(user).to be_valid
    end

    it 'rejects invalid phone numbers' do
      user.phone_number = '12345'
      expect(user).not_to be_valid
      expect(user.errors[:phone_number]).to include('must be exactly 10 digits')

      user.phone_number = '12345678901'
      expect(user).not_to be_valid
      expect(user.errors[:phone_number]).to include('must be exactly 10 digits')

      user.phone_number = '123-456-7890'
      expect(user).not_to be_valid
      expect(user.errors[:phone_number]).to include('must be exactly 10 digits')

      user.phone_number = 'not_a_phone_number'
      expect(user).not_to be_valid
      expect(user.errors[:phone_number]).to include('must be exactly 10 digits')
    end
  end

  describe 'scopes' do
    let!(:active_user) { create(:user, active: true) }
    let!(:inactive_user) { create(:user, active: false) }

    it 'returns only active users' do
      expect(User.active).to include(active_user)
      expect(User.active).not_to include(inactive_user)
    end

    it 'returns only inactive users' do
      expect(User.inactive).to include(inactive_user)
      expect(User.inactive).not_to include(active_user)
    end
  end

  describe 'callbacks' do
    it 'invalidates session token when password_digest changes' do
      user = create(:user, session_token: 'old_token')
      user.update(password: 'NewPassword123!', password_confirmation: 'NewPassword123!')
      expect(user.session_token).to be_nil
    end
  end

  describe 'instance methods' do
    let(:user) { build(:user, first_name: 'John', last_name: 'Doe', second_last_name: 'Smith') }

    describe '#full_name' do
      it 'returns the full name of the user' do
        expect(user.full_name).to eq('John Doe Smith')
      end
    end

    describe '#deactivate' do
      it 'sets the user as inactive' do
        user = create(:user, active: true)
        user.deactivate
        expect(user.reload.active).to be_falsey
      end
    end

    describe '#activate' do
      it 'sets the user as active' do
        user = create(:user, active: false)
        user.activate
        expect(user.reload.active).to be_truthy
      end
    end
  end
end
