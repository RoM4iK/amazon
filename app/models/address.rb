class Address < ActiveRecord::Base
    has_one :country
    belongs_to :customer

    validates :address, presence: true
    validates :zipcode, presence: true, numericality: true
    validates :city, presence: true
    validates :phone, presence: true
    validates :country, presence: true

end
