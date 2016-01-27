FactoryGirl.define do
  factory :customer do
    first_name { Faker::Name.first_name }
    email { Faker::Internet.safe_email }
    last_name { Faker::Name.last_name }
    password { Faker::Internet.password }
  end
end