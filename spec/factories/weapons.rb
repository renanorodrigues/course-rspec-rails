FactoryBot.define do
  factory :weapon do
    name { FFaker::NameBR.first_name }
    description { FFaker::Lorem.phrase }
    power_base { FFaker::Random.rand(1..9999) }
    level { FFaker::Random.rand(1..99) }
    power_step { FFaker::Random.rand(100..9999) }
  end
end
