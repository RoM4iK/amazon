require 'factory_girl_rails'

AUTHORS_COUNT = 30
CATEGORIES_COUNT = 10

# create 10 unique categories
category_titles = []
while category_titles.size < 10
  category_titles << Faker::Book.genre
  category_titles.uniq!
end

# seed categories
category_titles.each do |title|
  FactoryGirl.create(:category, title: title)
end

# seed authors
FactoryGirl.create_list(:author, AUTHORS_COUNT)

# seed books
authors = Author.all
Category.all.each do |category|
  10.times do
    FactoryGirl.create(:book, author: authors[rand(0..AUTHORS_COUNT)], category: category, ratings_count: rand(0...5))
  end
end

#seed delivieries
delivieries = [
  {
    name: 'NewPost',
    price: '30',
    description: 'Delivery in 2-3 days'
  },
  {
    name: 'Ukrainian Post',
    price: '0',
    description: 'Delivery in 30-90 days'
  },
  {
    name: 'Slowpoke',
    price: '0',
    description: 'Delivery in 10-14 days'
  },
]

ShopperEngine::Delivery.create(delivieries)

#seed countries

countries = [
  {
    name: "Ukraine"
  },
  {
    name: "Russian Federation"
  },
  {
    name: "Belarus"
  },
  {
    name: "United States"
  },
  {
    name: "North Korea"
  }
]

ShopperEngine::Country.create(countries)
