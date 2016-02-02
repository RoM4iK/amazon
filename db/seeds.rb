require 'factory_girl_rails'

AUTHORS_COUNT = 30
CATEGORIES_COUNT = 10

category_titles = []
while category_titles.size < 10
  category_titles << Faker::Book.genre
  category_titles.uniq!
end

category_titles.each do |title|
  FactoryGirl.create(:category, title: title)
end

FactoryGirl.create_list(:author, AUTHORS_COUNT)

authors = Author.all
Category.all.each do |category|
  10.times do
    FactoryGirl.create(:book, author: authors[rand(0..AUTHORS_COUNT)], category: category, ratings_count: rand(0...5))
  end
end