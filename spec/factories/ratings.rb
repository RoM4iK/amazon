FactoryGirl.define do
  factory :rating do

    text { Faker::Lorem.sentence }
    rate { Faker::Number.between(0, 5) }
    
    after(:build) do |rating, evaluator|
      if rating.customer.blank? 
        rating.customer = build(:customer)
      end
      if rating.book.blank? 
        rating.book = build(:book)
      end
    end
    
    after(:create) do |rating, evaluator|
      if rating.customer.blank? 
        rating.customer = create(:customer)
      end
      if rating.book.blank? 
        rating.book = create(:book)
      end
    end

    
  end
end