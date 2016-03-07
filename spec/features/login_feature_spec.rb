require 'rails_helper'

TEST_PASSWORD = 'testpassword'
feature "Login" do
  before do
    @customer = FactoryGirl.create(:customer, password: TEST_PASSWORD)
  end
  scenario "Visitor registers successfully via register form" do
    visit new_customer_session_path
    within '#new_customer' do
      fill_in 'Email', with: @customer.email
      fill_in 'Password', with: TEST_PASSWORD
      click_button('Log in')
    end
    expect(page).not_to have_content 'Log in'
    expect(page).to have_content 'Signed in successfully.'
  end

  scenario "Should be an errors when data is incorrect" do
    visit new_customer_session_path
    within '#new_customer' do
      fill_in 'Email', with: @customer.email
      fill_in 'Password', with: ''
      click_button('Log in')
    end
    expect(page).to have_content 'Log in'
    expect(page).to have_selector '.alert-danger'
  end
end