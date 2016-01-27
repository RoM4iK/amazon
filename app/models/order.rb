class Order < ActiveRecord::Base
    # class << self
        PAYMENT = 0
        SHIPPING = 1
        FINISHED = 2
    # end
    
    belongs_to :customer
    belongs_to :credit_card
    has_many :order_items
    
    validates :state, presence: true
    validates :credit_card, presence: true
    validates :customer, presence: true

    def add_item(book, quantity = 1)
        order_items.create({book: book, quantity: quantity, price: book.price})
        update_price(book.price)
    end
    
    def remove_item(order_item, quantity = 1)
       order_items.delete(order_item)
       update_price(-order_item.price)
    end
    
    def update_price(price)
        self.price += price
    end
    
    scope :in_progress, -> { where("state != #{self::FINISHED}") }
    
end
