require 'rails_helper'

RSpec.describe "books/index", type: :view do
  before(:each) do
    @book = FactoryGirl.create_list(:book, 2)
  end

  it "renders a list of books" do
    render
  end
end
