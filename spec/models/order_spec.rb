require 'rails_helper'

RSpec.describe Order, type: :model do
  it { is_expected.to belong_to(:credit_card) }
  it { is_expected.to belong_to(:customer) }
  it { is_expected.to have_many(:order_items) }
    
  it { is_expected.to validate_presence_of(:state) }
  
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
    describe 'adding more than 1 book quantity' do
      it 'changes order price' do
        expect { @order.add_item(@book, 2) }.to change{ @order.price }.from(0).to(@book.price * 2)
      end
      it 'dont create 2 order items' do
        expect { @order.add_item(@book, 2) }.to change{ @order.order_items.size }.from(0).to(1)
      end
    end
    describe 'adding book that previosly added' do
      before do
        @order.add_item(@book)
      end
      it 'dont change the order size' do
        expect { @order.add_item(@book) }.not_to change{ @order.order_items.size }
      end
      it 'changes order price' do
        expect { @order.add_item(@book) }.to change{ @order.price }.from(@book.price).to(@book.price * 2)
      end
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
  describe '#update_quantity' do
    before do
      @order = FactoryGirl.create(:order, order_items_count: 1)
      @order_item = @order.order_items.first
    end
    context 'with positive quantity' do
      new_quantity = 12
      it 'must change the quantity' do
        expect(@order_item).to receive(:update_quantity).with(new_quantity)
        @order.update_quantity(@order_item, new_quantity)
      end
      it 'must save the order item' do
        expect(@order_item).to receive(:save)
        @order.update_quantity(@order_item, new_quantity)
      end
    end
    context 'with 0 or negative quantity' do
      new_quantity = 0
      it 'must delete the order item' do
        expect(@order_item).to receive(:delete)
        @order.update_quantity(@order_item, new_quantity)
      end
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
