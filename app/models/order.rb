class Order < ActiveRecord::Base
    PAYMENT = 0
    SHIPPING = 1
    FINISHED = 2

    belongs_to :customer
    belongs_to :credit_card
    has_many :order_items

    validates :state, presence: true


    def add_item(book, quantity = 1)
        order_item = order_items.find_by({book: book})
        if (order_item)
           order_item.update_quantity(order_item.quantity + quantity)
           order_item.save
        else
            order_items.create({book: book, quantity: quantity, price: book.price * quantity})
        end
        update_price!
    end

    def update_quantity(order_item, quantity)
      if (quantity <= 0)
        order_item.delete
      else
        order_item.update_quantity(quantity)
        order_item.save
      end
      update_price!
    end

    def remove_item(order_item, quantity = 1)
       order_items.delete(order_item)
       update_price!
    end

    def update_price!
        self.price = order_items.sum("price")
        save
    end

    scope :in_progress, -> { where("state != #{self::FINISHED}") }

end
