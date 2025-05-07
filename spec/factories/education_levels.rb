FactoryBot.define do
  factory :education_level do
    description { Faker::Educator.degree }
  end
end
