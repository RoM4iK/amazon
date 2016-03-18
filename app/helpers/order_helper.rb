module OrderHelper
  def add_to_cart_button(book)
    @book = book
    render partial: 'orders/add_to_cart_button'
  end
end
