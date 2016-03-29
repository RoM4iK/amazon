class Customer < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

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

  def self.from_omniauth(auth)
    where(uid: auth.uid).first_or_create do |customer|
      customer.email = auth.info.email
      customer.password = Devise.friendly_token[0,20]
      customer.first_name = auth.info.first_name
      customer.last_name = auth.info.last_name
    end
  end
end
