FactoryBot.define do
  factory :insurer do
    description { Faker::Company.name }
  end
end
