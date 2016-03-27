require 'rails_helper'
require 'support/checkout_context'

feature "Checkout addresses" do
  include_context 'checkout_context'
  context "User have no saved addresses" do
    before do
      visit checkout_path(id: 'billing')
    end
    scenario "Should not render address select form" do
      expect(page).to_not have_selector('form.edit_order')
    end
  end
  context "User have saved addresses" do
    before do
      FactoryGirl.create(:address, customer: @customer)
      visit checkout_path(id: 'billing')
    end
    scenario "Should render address select form" do
      expect(page).to have_selector('form.edit_order')
    end
  end
end
