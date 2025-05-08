FactoryBot.define do
  factory :education_level do
    description { Faker::Educator.unique.degree }
  end
end
