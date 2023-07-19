FactoryBot.define do
  factory :car do
    name { 'Test Car' }
    description { 'Test description' }
    cost_per_day { 100 }
  end
end
