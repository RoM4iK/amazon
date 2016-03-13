require 'rails_helper'
RSpec.describe CartController, type: :controller do
  describe '#add' do
    before do
      @book = FactoryGirl.create(:book)
      @quantity = 10
    end
    it 'must find book' do
      expect(Book).to receive(:find).with(@book.id).and_call_original
      post :add, book: @book, quantity: @quantity
    end
    it 'must add it to order' do
      expect_any_instance_of(Order).to receive(:add_item).with(@book, @quantity)
      post :add, book: @book, quantity: @quantity
    end
    it 'must set flash notice' do
      post :add, book: @book, quantity: @quantity
      expect(controller).to set_flash
    end
    it 'must redirect to root' do
      post :add, book: @book, quantity: @quantity
      expect(controller).to redirect_to :root
    end
  end

  describe '#change_quantity', :not_verify_doubles do
    before do
      @book = FactoryGirl.create(:book)
      @order = FactoryGirl.create(:order)
      @quantity = 10
      @order.add_item(@book)
      @order_item = @order.order_items.where(book: @book).first
      allow_any_instance_of(CartController).to receive(:current_order) { @order }
    end
    it 'must update quantity of order item' do
      expect(@order).to receive(:update_quantity).with(@order_item, @quantity)
      post :change_quantity, book: @book, quantity: @quantity
    end
    it 'must redirect to index' do
      post :change_quantity, book: @book, quantity: @quantity
      expect(controller).to redirect_to action: :index
    end
  end
end
