FactoryBot.define do
  factory :insurer do
    description { Faker::Company.unique.name }
  end
end
