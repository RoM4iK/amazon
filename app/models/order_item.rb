class OrderItem < ActiveRecord::Base
    belongs_to :book
    belongs_to :order
    
    def update_quantity (value)
      self.price = book.price * value
      self.quantity = value
    end
    
    validates :price, presence: true
    validates :quantity, presence: true
end
