class CreditCard < ActiveRecord::Base
    belongs_to :customer
    has_many :orders
    
    validates :number, presence: true, uniqueness: true
    validates :cvv, presence: true
    validates :expiration_month, presence: true
    validates :expiration_year, presence: true
    validates :first_name, presence: true
    validates :last_name, presence: true
end
