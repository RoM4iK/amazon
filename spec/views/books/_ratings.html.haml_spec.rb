require 'rails_helper'

RSpec.describe "books/_ratings", type: :view do
  before do
    @rating = FactoryGirl.create(:rating)
    render partial: 'books/ratings', locals: {rating: @rating}
  end
  it 'must render stars with average rate' do
    expect(rendered).to have_selector('.book-stars')
  end
  it 'must render customer name' do
    expect(rendered).to have_content(@rating.customer.full_name)
  end
  it 'must render review time' do
    expect(rendered).to have_content(time_ago_in_words(@rating.created_at))
  end
  it 'must render review text' do
    expect(rendered).to have_content(@rating.text)
  end
end
