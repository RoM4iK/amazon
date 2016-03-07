module CartHelper
  def add_to_cart_button(book)
    @book = book
    render partial: 'cart/add_to_cart_button'
  end
end
