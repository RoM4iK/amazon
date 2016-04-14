class Customer < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  acts_as_customer

  has_many :ratings

  validates :first_name, presence: true
  validates :last_name, presence: true

  def full_name
    "#{first_name} #{last_name}"
  end

  def admin?
    self.admin
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
