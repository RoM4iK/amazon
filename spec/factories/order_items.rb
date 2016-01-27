FactoryGirl.define do
  factory :order_item do
    
    quantity { Faker::Number.between(1, 5) }
    
    after(:build) do |order_item, evaluator|
      if order_item.book.blank? 
        order_item.book = build(:book)
        order_item.price = order_item.book.price
      end
    end
    
    after(:create) do |order_item, evaluator|
      if order_item.book.blank? 
        order_item.book = create(:book)
        order_item.price = order_item.book.price
      end
    end
  end
end