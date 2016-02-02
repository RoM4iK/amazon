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
  
  describe "#current_order" do
    before do
      @customer = FactoryGirl.create(:customer)
    end
    describe "When user have no active order" do
      it "must create new order and make it active" do
        expect(@customer.orders).to receive("create!").with(state: Order::PAYMENT)
        @customer.current_order
      end
    end
    describe "When user have active order" do
      before do
        @order = @customer.current_order
        @order.add_item(FactoryGirl.create(:book))
      end
      it "must not creates new order" do
        expect(@customer.orders).not_to receive("create!")
        @customer.current_order
      end
      it "must return active order" do
        expect(@customer.current_order).to eq(@order)
      end
    end
  end
end
