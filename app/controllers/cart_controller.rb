class CartController < ApplicationController
  before_action :get_current_order
  
  def index
  end
  
  def add
    book = Book.find(params[:book])
    @order.add_item(book, params[:quantity].to_i)
    flash.notice = 'Book added to your cart'
    redirect_to :root
  end
  
  private
  
  def get_current_order
    if current_customer.present?
      customer_current_order = current_customer.current_order
      if (session[:cart_id])
        customer_current_order.delete
        @order = Order.find(session[:cart_id])
        @order.customer = current_customer
        @order.save
        session[:cart_id] = nil
      else
        @order = customer_current_order
      end
    else
      if (session[:cart_id])
        @order = Order.find(session[:cart_id])
      else
        @order = Order.create!(state: Order::PAYMENT)
        session[:cart_id] = @order.id
      end
    end
  end
end
