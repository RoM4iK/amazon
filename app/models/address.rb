class Address < ActiveRecord::Base
    belongs_to :country
    belongs_to :customer

    validates :address, presence: true
    validates :zipcode, presence: true, numericality: true
    validates :city, presence: true
    validates :phone, presence: true
    validates :country, presence: true
    
    def orders
        Order.where("billing_address = ? OR shipping_address = ?", self.id, self.id)
    end

end
