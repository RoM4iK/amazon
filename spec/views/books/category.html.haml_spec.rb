require 'rails_helper'
require 'views/books/shared_examples/book_list'

RSpec.describe "books/category", type: :view do
  before do
    @category = FactoryGirl.create(:category)
    @books_list =FactoryGirl.create_list(:book, 2, category: @category)
  end
  it_behaves_like "a book list"
end
