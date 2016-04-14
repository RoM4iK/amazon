class Book < ActiveRecord::Base
    acts_as_product

    belongs_to :author
    belongs_to :category
    has_many :ratings

    validates :title, presence: true
    validates :price, presence: true
    validates :quantity, presence: true
end
