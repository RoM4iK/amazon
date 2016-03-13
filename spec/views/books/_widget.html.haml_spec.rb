require 'rails_helper'

RSpec.describe "books/_widget", type: :view do
  before do
    render partial: 'books/widget', locals: {book: FactoryGirl.create(:book)}
  end
  it "renders widget" do
    expect(rendered).to have_selector('.book-widget')
  end
  it 'have book price' do
    expect(rendered).to have_selector('.book-widget .price')
  end
  it 'have book title' do
    expect(rendered).to have_selector('.book-widget .title')
  end
  it 'have book category' do
    expect(rendered).to have_selector('.book-widget .category')
  end
  it 'have book author' do
    expect(rendered).to have_selector('.book-widget .author')
  end
  it 'have book ratings' do
    expect(rendered).to have_selector('.book-widget .ratings')
  end
  it 'have add to cart button' do
    expect(rendered).to have_selector('.book-widget .add-to-cart-button')
  end
end
