FactoryGirl.define do
  factory :delivery do
    name { Faker::Company.name }
    description { Faker::Company.buzzword }
    price { Faker::Commerce.price }
  end
end
