require 'rails_helper'
require 'support/checkout_context'

feature "Checkout" do
  context "User has logged in" do
    include_context 'checkout_context'
    scenario "Should redirect to fisrt checkout step" do
      expect(current_path).to eq(checkout_path id: 'billing')
    end
  end
  context "User has not logged in" do
    before do
      @book = FactoryGirl.create(:book)
      visit root_path
      within('.add-to-cart-button') do
        click_button 'Buy'
      end
      visit cart_path
      click_link 'Checkout'
    end
    scenario "Should redirect to login page" do
      expect(current_path).to eq(new_customer_session_path)
    end
  end
end
