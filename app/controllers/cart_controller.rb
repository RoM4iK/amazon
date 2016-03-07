class CartController < ApplicationController
  before_action :authenticate_customer!
  before_action :get_current_order
  
  def index
  end
  
  def add
    book = Book.find!(params[:book])
    @order.add_item(book, params[:quantity])
    redirect_to :index
  end
  
  private
  
  def get_current_order
    @order = current_customer.current_order
  end
end
