FactoryBot.define do
  factory :appointment do
    date { Faker::Date.forward(days: 30) }
    time { Faker::Time.forward(days: 30, period: :morning) }
    details { Faker::Lorem.paragraph }
    status { :active }
    association :patient
    association :doctor, factory: :user
  end
end
