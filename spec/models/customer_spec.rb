require 'rails_helper'

RSpec.describe Customer, type: :model do
  it { is_expected.to have_many(:orders) }
  it { is_expected.to have_many(:ratings) }

  it { is_expected.to validate_presence_of(:first_name) }
  it { is_expected.to validate_presence_of(:last_name) }


  describe "#full_name" do
    before do
      @customer = FactoryGirl.build(:customer)
    end
    it 'must return first name + last name' do
      expect(@customer.full_name).to eq("#{@customer.first_name} #{@customer.last_name}")
    end
  end
    
end
