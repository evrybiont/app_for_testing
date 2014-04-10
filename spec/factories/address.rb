FactoryGirl.define do
  factory :address do
    country     'Ukraine'
    state       Faker::Address.state
    sity        Faker::Address.city
    street      Faker::Address.street_name
    association :hotel
  end
end
