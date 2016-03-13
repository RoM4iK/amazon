FactoryGirl.define do
  factory :book do
    transient do
      ratings_count 0
    end
    title { Faker::Book.title }
    description { Faker::Lorem.paragraph }
    price { Faker::Number.between(1, 100) }
    quantity { Faker::Number.between(0, 10) }

    after(:build) do |book, evaluator|
      if book.author.blank?
        book.author = build(:author)
      end
      if book.category.blank?
        book.category = build(:category)
      end
      FactoryGirl.build_list(:rating, evaluator.ratings_count ,book: book)
    end

    after(:create) do |book, evaluator|
      if book.author.blank?
        book.author = create(:author)
      end
      if book.category.blank?
        book.category = create(:category)
      end
      FactoryGirl.create_list(:rating, evaluator.ratings_count ,book: book)
    end

  end
end
