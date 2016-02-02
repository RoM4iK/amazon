class CartController < ApplicationController
  before_action :authenticate_customer!
  
  def index
    @order = current_customer.current_order
  end
end
