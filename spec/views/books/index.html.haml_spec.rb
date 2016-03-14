require 'rails_helper'
require 'views/books/shared_examples/book_list'

RSpec.describe "books/index", type: :view do
  before do
    @books_list = FactoryGirl.create_list(:book, 2)
  end
  it_behaves_like "a book list"
end
