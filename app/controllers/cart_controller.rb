class CartController < ApplicationController
  include ApplicationHelper
  before_action :get_current_order

  def index
  end

  def add
    book = Book.find(params[:book].to_i)
    @order.add_item(book, params[:quantity].to_i)
    flash.notice = 'Book added to your cart'
    redirect_to :root
  end

  def change_quantity
    order_item = @order.order_items.where(book: params[:book]).first
    @order.update_quantity(order_item, params[:quantity].to_i)
    redirect_to(action: :index)
  end

  private

  def get_current_order
    @order = current_order
  end
end
