require 'rails_helper'

feature "Registration" do
  scenario "Visitor registers successfully via register form" do
    visit new_customer_registration_path
    within '#new_customer' do
      fill_in 'Email', with: Faker::Internet.email
      fill_in 'Password', with: '12345678'
      fill_in 'Password confirmation', with: '12345678'
      fill_in 'First name', with: Faker::Name.first_name
      fill_in 'Last name', with: Faker::Name.last_name
      click_button('Sign up')
    end
    expect(page).not_to have_content 'Sign up'
    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end

  scenario "Should be an errors when data is incorrect" do
    visit new_customer_registration_path
    within '#new_customer' do
      fill_in 'Email', with: 'asdf@mail.ru'
      fill_in 'Password', with: '12'
      fill_in 'Password confirmation', with: '12345'
      fill_in 'First name', with: ''
      fill_in 'Last name', with: ''
      click_button('Sign up')
    end
    expect(page).to have_content 'Sign up'
    expect(page).to have_selector '#error_explanation'
  end
end