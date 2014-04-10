FactoryGirl.define do
  factory :user do
    token    Faker::Code.isbn
    email    Faker::Internet.safe_email
    password Faker::Internet.password(6)
  end
end
