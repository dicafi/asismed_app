FactoryBot.define do
  factory :medical_note do
    ta { '120/80' }
    spo2 { '98' }
    temperature { 36.5 }
    glucose { 90.0 }
    fr { 18.0 }
    fc { 72.0 }
    weight { 70.5 }
    height { 1.75 }
    current_condition { Faker::Lorem.paragraph }
    physical_examination { Faker::Lorem.paragraph }
    treatment_plan { Faker::Lorem.paragraph }
    prognosis { Faker::Lorem.sentence }

    association :appointment
  end
end
