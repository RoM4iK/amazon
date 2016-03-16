class CheckoutController < ApplicationController
  include Wicked::Wizard

  before_action :get_current_order

  steps :billing, :shipping, :delivery, :payment, :confirmation

  def show
    # @user = current_user
    case step
      when :billing
          billing
      when :shipping
        shipping
      when :delivery
        delivery
      when :payment
        payment
    end
    render_wizard
  end

  def update

  end

  private

  def get_current_order
    @order = current_customer.current_order
  end

  def billing
    @billing_address = @order.billing_address || Address.new
  end

  def shipping
    @shipping_address = @order.shipping_address || Address.new
    @shipping_address = Address.new if @shipping_address == @order.billing_address
  end

  def delivery
  end

  def payment
    @credit_card = @order.credit_card || CreditCard.new
  end
end
