require 'rails_helper'

RSpec.describe Customer, type: :model do
  it { is_expected.to have_many(:orders) }
  it { is_expected.to have_many(:ratings) }
  
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:first_name) }
  it { is_expected.to validate_presence_of(:last_name) }
  it { is_expected.to validate_presence_of(:password) }
  it { is_expected.to validate_confirmation_of(:password) }
  it { is_expected.to validate_uniqueness_of(:email) }
  
  describe '#orders_in_progress' do
     it 'must return orders'
     it 'must not return finished orders'
  end
end
