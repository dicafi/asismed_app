FactoryBot.define do
  factory :marital_status do
    description { Faker::Demographic.marital_status }
  end
end
