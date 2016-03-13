require 'rails_helper'

RSpec.describe "devise/sessions/new", type: :view do
  before do
    render
  end
  it 'has email field' do
    expect(rendered).to have_selector('#customer_email')
  end
  it 'has password field' do
    expect(rendered).to have_selector('#customer_password')
  end
end
