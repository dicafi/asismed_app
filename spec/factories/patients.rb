FactoryBot.define do
  factory :patient do
    name { Faker::Name.name }
    last_name { Faker::Name.last_name }
    second_last_name { Faker::Name.last_name }
    birth_date { Faker::Date.birthday(min_age: 0, max_age: 120) }
    phone_number { rand(10**9..10**10 - 1).to_s }
    email { Faker::Internet.email }
    gender { :masculino }
    occupation { Faker::Job.title }
    postal_code { Faker::Address.zip_code }
    state { Faker::Address.state }
    municipality { Faker::Address.city }
    neighborhood { Faker::Address.community }
    address { Faker::Address.street_address }
    origin { Faker::Address.country }
    religion { Faker::Religion.name }
    interrogation { :directo }
    association :education_level
    association :marital_status
    association :insurer
  end
end
