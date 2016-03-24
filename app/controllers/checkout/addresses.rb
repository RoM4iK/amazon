module Checkout::Addresses
  def billing
    @billing_address = @order.billing_address || current_customer.addresses.new
  end

  def update_billing
    @billing_address = @order.billing_address || current_customer.addresses.new
    @billing_address.attributes = params.require(:address).permit(:address, :zipcode, :city, :phone, :country_id)
    @billing_address.save!
    @order.billing_address = @billing_address
    @order.save
    redirect_to next_wizard_path
  end
  
  def shipping
    @shipping_address = @order.shipping_address || current_customer.addresses.new
    @shipping_address = current_customer.addresses.new if @shipping_address == @order.billing_address
  end

  def update_shipping
    @shipping_address = @order.shipping_address || current_customer.addresses.new
    @shipping_address = current_customer.addresses.new if @shipping_address == @order.billing_address
    if params.permit(:skip_shipping)[:skip_shipping] == "true"
      skip_shipping
    else
      @shipping_address.attributes = params.require(:address).permit(
        :address, :zipcode, :city, :phone, :country_id
      )
      @shipping_address.save!
      @order.shipping_address = @shipping_address
      @order.save
    end
    redirect_to next_wizard_path
  end

  def skip_shipping
    @order.update shipping_address: @order.billing_address
    @order.save
  end
end