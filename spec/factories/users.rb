FactoryBot.define do
  fake_password = "#{Faker::Internet.password(min_length: 6, mix_case: true)}@$!%*?&1"

  factory :user do
    username { Faker::Internet.email }
    password { fake_password }
    password_confirmation { fake_password }
    session_token { SecureRandom.hex(16) }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    date_of_birth { Faker::Date.birthday(min_age: 18, max_age: 90) }
    phone_number { rand(10**9..10**10 - 1).to_s }
    profile { Faker::Lorem.word }
    signature { Faker::Internet.url }
    active { true }
  end
end
