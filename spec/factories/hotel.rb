FactoryGirl.define do
  factory :hotel do
    title               Faker::Name.title
    star_rating         4
    breakfast_included  '1'
    room_description    Faker::Lorem.sentences
    price_for_room      50
    association         :user
  end

  factory :top, parent: :hotel do
    sequence(:star_rating)
    user nil
  end

  factory :hotel_without_user, parent: :hotel do
    user nil
  end
end
