class Rating < ActiveRecord::Base
    belongs_to :book
    belongs_to :customer
    
    validates :rate, presence: true, numericality: {less_than: 11, only_integer: true}
end
