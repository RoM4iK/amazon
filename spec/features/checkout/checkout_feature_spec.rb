require 'rails_helper'
require 'support/checkout_context'

feature "Checkout" do
  describe "User can open checkout page" do
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
  describe "User can fill checkout forms" do
    include_context 'checkout_context'
    before do
      FactoryGirl.create(:country)
    end
    context "With correct data" do
      before do
        @first_path = checkout_path(id: :billing)
        @address = FactoryGirl.build(:address)
        visit @first_path
        within '#new_address' do
          fill_in 'Address', with: @address.address
          fill_in 'Zipcode', with: @address.zipcode
          fill_in 'City', with: @address.city
          fill_in 'Phone', with: @address.phone
          click_button 'Save'
        end
      end
      scenario "should redirect to next step" do
        expect(current_path).to_not eq(@first_path)
      end
    end
    context "With incorrect data" do
      before do
        @first_path = checkout_path(id: :billing)
        visit @first_path
        within '#new_address' do
          click_button 'Save'
        end
      end
      scenario "should not redirect to not step" do
        expect(current_path).to eq(@first_path)
      end
      scenario "should display validation errors" do
        expect(page).to have_selector('.alert-danger')
      end
    end
  end
end
