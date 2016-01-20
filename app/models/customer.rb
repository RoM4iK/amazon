class Customer < ActiveRecord::Base
    has_many :orders
    has_many :ratings
    
    validates :email, presence: true, uniqueness: true
    validates :password, presence: true, confirmation: true
    validates :first_name, presence: true
    validates :last_name, presence: true
end
