require 'rails_helper'

RSpec.describe "books/_stars", type: :view do
  context("with 5 stars") do
    before do
      count = 5
      render partial: 'books/stars', locals: {count: count}
    end
    it 'must render full stars' do
      expect(rendered).to have_selector('.glyphicon-star')
    end
    it 'must not render empty stars' do
      expect(rendered).not_to have_selector('.glyphicon-star-empty')
    end
  end
  context("with 0 stars") do
    before do
      count = 0
      render partial: 'books/stars', locals: {count: count}
    end
    it 'must render empty stars' do
      expect(rendered).to have_selector('.glyphicon-star-empty')
    end
    it 'must not render full stars' do
      expect(rendered).not_to have_selector('.glyphicon-star')
    end
  end
  context("with 1-4 stars") do
    before do
      count = 2
      render partial: 'books/stars', locals: {count: count}
    end
    it 'must render full stars' do
      expect(rendered).to have_selector('.glyphicon-star')
    end
    it 'must render empty stars' do
      expect(rendered).to have_selector('.glyphicon-star-empty')
    end
  end
end
