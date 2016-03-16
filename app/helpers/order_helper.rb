module OrderHelper
  def add_to_cart_button(book)
    @book = book
    render partial: 'order/add_to_cart_button'
  end
end
