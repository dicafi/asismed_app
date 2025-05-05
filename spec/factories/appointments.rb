FactoryBot.define do
  factory :appointment do
    date { "2025-05-01" }
    time { "2025-05-01 23:04:10" }
    patient { nil }
    doctor { nil }
    details { "MyText" }
    medical_note { nil }
  end
end
