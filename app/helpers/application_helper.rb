module ApplicationHelper
  def current_order
    if current_customer.present?
      order_for_logged_user
    else
      order_for_unlogged_user
    end
  end

  def cart_total
    current_order.price
  end

  private

  def order_for_logged_user
    if (session[:cart_id])
      order = update_customer_order
    else
      order = current_customer.current_order
    end
    order
  end

  def order_for_unlogged_user
    if (session[:cart_id])
      order = order_from_session
    else
      order = store_order_to_session
    end
    order
  end

  def order_from_session
    Order.find(session[:cart_id])
  end

  def store_order_to_session
    order = Order.create!(state: Order::PAYMENT)
    session[:cart_id] = order.id
    order
  end

  def update_customer_order
    current_customer.current_order.delete
    order = order_from_session
    order.customer = current_customer
    order.save
    session[:cart_id] = nil
    order
  end

end
