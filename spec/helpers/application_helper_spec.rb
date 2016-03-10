require 'rails_helper'

describe ApplicationHelper, :not_verify_doubles do
  before do
    @helper = Object.new.extend ApplicationHelper
    @session = Hash.new
    allow(@helper).to receive(:session) { @session }
  end
  describe '#current_order'  do
  	it 'may retrieve order for logged user'do
  		allow(@helper).to receive(:current_customer) { Customer.new }
  		expect(@helper).to receive(:order_for_logged_user)
  		@helper.current_order
  	end
  	it 'may retrieve order for unlogged user' do
      allow(@helper).to receive(:current_customer) { nil }
      expect(@helper).to receive(:order_for_unlogged_user)
      @helper.current_order
    end
  end
  describe '#cart_total' do
    before do
      @order = double("Order")
      allow(@helper).to receive(:current_order) { @order }
    end
  	it 'must return cart total price' do
      expect(@order).to receive(:price)
      @helper.cart_total
    end
  end
  describe '#order_for_logged_user' do
  	it 'must update order if session order exist' do
      @session[:cart_id] = 1
      expect(@helper).to receive(:update_customer_order)
      @helper.send(:order_for_logged_user)
    end
  	it 'must return current order' do
      expect(@helper).to receive_message_chain(:current_customer, :current_order)
      @helper.send(:order_for_logged_user)
    end
  end
  describe '#order_for_unlogged_user' do
  	it 'must return order from session' do
      @session[:cart_id] = 1
      expect(@helper).to receive(:order_from_session)
      @helper.send(:order_for_unlogged_user)
    end
  	it 'must create order if its not exist' do
      expect(@helper).to receive(:store_order_to_session)
      @helper.send(:order_for_unlogged_user)
    end
  end
  describe '#order_from_session' do
  	it 'must retrieve order from session' do
      @session[:cart_id] = 1
      expect(Order).to receive(:find).with(1)
      @helper.send(:order_from_session)
    end
  end
  describe '#store_order_to_session' do
    order_id = 1
    before do
      allow(Order).to receive(:create!) { FactoryGirl.build(:order, id: order_id)}
    end
  	it 'must create new order' do
      expect(Order).to receive(:create!)
      @helper.send(:store_order_to_session)
  	end
  	it 'must store it id to session' do
      expect{@helper.send(:store_order_to_session)}.to change{@session[:cart_id]}.from(nil).to(order_id)
    end
  end
  describe '#update_customer_order' do
    before do
      @order = FactoryGirl.build(:order)
      @old_order = FactoryGirl.build(:order)
      @customer = FactoryGirl.build(:customer)
      allow(@helper).to receive(:order_from_session) { @order }
      allow(@helper).to receive(:current_customer) { @customer }
      allow(@customer).to receive(:current_order) { @old_order}
    end
  	it 'must delete old order' do
  	  expect(@old_order).to receive(:delete)
      @helper.send(:update_customer_order)
  	end
  	it 'must retrieve order from session' do
  	  expect(@helper).to receive(:order_from_session)
      @helper.send(:update_customer_order)
  	end
  	it 'must assign order to customer' do
      expect{@helper.send(:update_customer_order)}.to change{@order.customer}.to(@customer)
  	end
  	it 'must save the order' do
      expect(@order).to receive(:save)
      @helper.send(:update_customer_order)
  	end
  	it 'must clear the session order' do
        @session[:cart_id] = 911
        expect{@helper.send(:update_customer_order)}.to change{@session[:cart_id]}.from(911).to(nil)
  	end
  end
end
