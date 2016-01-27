FactoryGirl.define do
  factory :book do
    title { Faker::Book.title }
    description { Faker::Lorem.sentence }
    price { Faker::Commerce.price }
    quantity { Faker::Number.between(0, 10) }
    
    after(:build) do |book, evaluator|
      if book.author.blank? 
        book.author = build(:author)
      end
      if book.category.blank? 
        book.category = build(:category)
      end
    end
    
  end
end