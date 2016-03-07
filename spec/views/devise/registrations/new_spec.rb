require 'rails_helper'
include DeviseHelpers
 
describe 'devise/registrations/new', type: :view do
  before do
    render
  end
  it 'has first name field' do
    expect(rendered).to have_selector('#customer_first_name')
  end
  it 'has last name field' do
    expect(rendered).to have_selector('#customer_last_name')
  end
  it 'has email field' do
    expect(rendered).to have_selector('#customer_email')
  end
  it 'has password field' do
    expect(rendered).to have_selector('#customer_password')
  end
  it 'has password confimartion field' do
    expect(rendered).to have_selector('#customer_password_confirmation')
  end
  it 'has submit button' do
    expect(rendered).to have_selector('#new_customer input[type="submit"]')
  end
end