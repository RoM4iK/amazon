class Order < ActiveRecord::Base
    belongs_to :customer
    belongs_to :credit_card
    has_many :order_items
    
    validates :price, presence: true
    validates :state, presence: true
    validates :credit_card, presence: true
    validates :customer, presence: true
end
