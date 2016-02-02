class Customer < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :confirmable, :validatable
         
  has_many :orders
  has_many :ratings
  
  validates :first_name, presence: true
  validates :last_name, presence: true
  
  def full_name
    "#{first_name} #{last_name}"
  end
  
  def current_order
     orders.where("state = #{Order::PAYMENT}").first || orders.create!(state: Order::PAYMENT)
  end
end
