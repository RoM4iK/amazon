require 'rails_helper'

feature "Add do cart" do
  before do
    @book = FactoryGirl.create(:book)
  end
  context "user adds 1 item to cart" do
    before do
      visit root_path
      within('.add-to-cart-button') do
        click_button 'Buy'
      end
    end
    scenario "must change the cart sum in header" do
      expect(page).to have_content "cart #{@book.price}$"
    end
    scenario "must show success alert" do
      expect(page).to have_selector('.alert-success')
    end
    scenario "must store item in cart" do
      click_link("cart")
      expect(page).to have_content(@book.title)
    end
  end
  skip context "user adds 'n' item to cart" do
    before do
      BOOK_COUNT = 10
      visit root_path
      # find(:css, "#book_widget_#{@book.id}_quantity").set(BOOK_COUNT)
      within("#book_widget_#{@book.id}") do
        # fill_in 'quantity', with: BOOK_COUNT
        fill_in 'quantity', with: BOOK_COUNT.to_s
        click_button 'Buy'
      end
    end
    scenario "must change the cart sum in header" do
      expect(page).to have_content "cart #{@book.price * BOOK_COUNT}$"
    end
  end
end
