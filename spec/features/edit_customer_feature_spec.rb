require 'rails_helper'
include Warden::Test::Helpers

feature "Edit customer" do
  before do
    @password = '12345678'
    @user = FactoryGirl.create(:customer, password: @password)
    login_as(@user, :scope => :customer)
    visit edit_customer_registration_path
  end
  scenario "user have prefilled input data" do
    expect(page).to have_field 'First name', with: @user.first_name
    expect(page).to have_field 'Last name', with: @user.last_name
  end
  context "user update their personal info with correct data" do
    before do
      @first_name = 'Test first name'
      within "#edit_customer" do
        fill_in 'First name', with: @first_name
        fill_in 'Current password', with: @password
        click_button('Update')
      end
    end
    scenario "must show success alert" do
      expect(page).to have_selector('.alert-success')
    end
    scenario "must change personal info" do
      visit edit_customer_registration_path
      expect(page).to have_field 'First name', with: @first_name
    end
  end
  context "user update their personal info with incorrect data" do
    before do
      @first_name = 'Test first name'
      within "#edit_customer" do
        fill_in 'First name', with: @first_name
        click_button('Update')
      end
    end
    scenario "doesn't change personal info" do
      expect(page).to have_content @user.first_name
    end
    scenario "must show devise errors" do
      expect(page).to have_selector('#error_explanation')
    end
  end
end
