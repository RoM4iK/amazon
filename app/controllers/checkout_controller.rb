class CheckoutController < ApplicationController
  include Wicked::Wizard

  before_action :authenticate_customer!
  before_action :get_current_order

  steps :billing, :shipping, :delivery, :payment, :confirmation

  def show
    return redirect_to cart_path if @order.order_items.empty?
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
    case step
      when :billing
        update_billing
      when :shipping
        update_shipping
      when :delivery
        update_delivery
      when :payment
        update_payment
    end
  end

  private

  def get_current_order
    @order = current_customer.current_order
    @billing_address = @order.billing_address || Address.new
    @shipping_address = @order.shipping_address || Address.new
    @credit_card = @order.credit_card || CreditCard.new
  end

  def billing
  end

  def update_billing
    @billing_address.attributes = params.require(:address).permit(:address, :zipcode, :city, :phone, :country_id)
    @billing_address.save
    @order.billing_address = @billing_address
    @order.save
    redirect_to next_wizard_path
  end

  def shipping
    @shipping_address = Address.new if @shipping_address == @order.billing_address
  end

  def update_shipping
    @shipping_address = Address.new if @shipping_address == @order.billing_address
    if params.permit(:skip_shipping)[:skip_shipping] == "true"
      skip_shipping
    else
      @shipping_address.attributes = params.require(:address).permit(
        :address, :zipcode, :city, :phone, :country_id
      )
      @shipping_address.save
      @order.shipping_address = @shipping_address
      @order.save!
    end
    redirect_to next_wizard_path
  end

  def skip_shipping
    @order.shipping_address = @billing_address
    @order.save!
  end

  def delivery
  end

  def update_delivery
    @order.update params.require(:order).permit(:delivery_id)
    redirect_to next_wizard_path
  end

  def payment
  end

  def update_payment
    @credit_card.attributes = params.require(:credit_card).permit(
      :number, :cvv, :expiration_month, :expiration_year, :first_name, :last_name
    )
    @credit_card.save
    @order.credit_card = @credit_card
    @order.save
    redirect_to next_wizard_path
  end
end
