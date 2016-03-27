FactoryGirl.define do
  factory :address do
    address { Faker::Address.street_address }
    zipcode { Faker::Number.number(5) }
    city { Faker::Address.city}
    phone { Faker::Number.number(8) }

    after(:build) do |address, evaluator|
      if address.customer.blank?
        address.customer = build(:customer)
      end
      if address.country.blank?
        address.country = FactoryGirl.build(:country)
      end
    end

    after(:create) do |address, evaluator|
      if address.customer.blank?
        address.customer = create(:customer)
      end
      if address.country.blank?
        address.country = FactoryGirl.create(:country)
      end
    end
  end
end
