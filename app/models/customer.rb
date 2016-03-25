class Customer < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders
  has_many :ratings
  has_many :addresses
  has_many :credit_cards

  validates :first_name, presence: true
  validates :last_name, presence: true

  def full_name
    "#{first_name} #{last_name}"
  end

  def admin?
    self.admin
  end

  def current_order
     orders.where("state = #{Order::PAYMENT}").first || orders.create!(state: Order::PAYMENT)
  end
end
