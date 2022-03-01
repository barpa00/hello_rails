FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Number.number(digits: 10) }
  end
end
