require 'rails_helper'

RSpec.describe Order, type: :model do
  it { is_expected.to belong_to(:credit_card) }
  it { is_expected.to belong_to(:customer) }
  it { is_expected.to have_many(:order_items) }
    
  it { is_expected.to validate_presence_of(:state) }
  it { is_expected.to validate_presence_of(:customer) }
  
  describe '#add_item' do
    before do
      @book = FactoryGirl.build(:book)
      @order = FactoryGirl.create(:order, order_items_count: 0)
    end
    it 'creates new order_item to this order' do
      expect { @order.add_item(@book) }.to change{ @order.order_items.size }.from(0).to(1)
    end
    it 'change the total price of order' do
      expect { @order.add_item(@book) }.to change{ @order.price }.from(0).to(@book.price)
    end
  end
  describe '#remove_item' do
    before do
      @order = FactoryGirl.create(:order, order_items_count: 1)
      @order_item = @order.order_items.first
    end
    it 'deletes order_item' do
      expect { @order.remove_item(@order_item) }.to change{ @order.order_items.size }.from(1).to(0)
    end
      
    it 'changes the total price of order' do
      expect { @order.remove_item(@order_item) }.to change{ @order.price }.from(@order_item.price).to(0)
    end
  end
  describe '#in_progress' do
    before do
      @customer = FactoryGirl.create(:customer)
      FactoryGirl.create(:order, customer: @customer, state: Order::PAYMENT)
      FactoryGirl.create(:order, customer: @customer, state: Order::FINISHED)
    end
    it 'must return orders' do
      expect(@customer.orders.in_progress).to all( be_a(Order) )
    end
    it 'must not return finished orders' do
      expect(@customer.orders.in_progress).to all( have_attributes(state: Order::PAYMENT) )
    end
  end
end
