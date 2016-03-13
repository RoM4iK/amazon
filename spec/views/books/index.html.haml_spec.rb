require 'rails_helper'

RSpec.describe "books/index", type: :view do
  context "with books" do
    before(:each) do
      @books = FactoryGirl.create_list(:book, 2)
      render
    end
    it "renders a list of books" do
      expect(rendered).to have_selector('.books-list')
    end
    it 'renders book widget' do
      expect(rendered).to have_selector('.book-widget')
    end
  end
  context "without books" do
    before do
      render
    end
    it "renders a list of books" do
      expect(rendered).to have_selector('.books-list')
    end
    it "doesn't render any book widget" do
      expect(rendered).not_to have_selector('.book-widget')
    end
  end
end
