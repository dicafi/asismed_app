FactoryBot.define do
  factory :diagnostic do
    key { Faker::Alphanumeric.alphanumeric(number: 10) }
    description { Faker::Lorem.unique.sentence(word_count: 3) }
  end
end
