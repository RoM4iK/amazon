class Ability
  include CanCan::Ability
  def initialize(customer)
    if customer
      can :create, Rating, customer_id: customer.id
      if customer.admin?
        can :access, :rails_admin
        can :dashboard
        can :manage, :all
      end
    end
  end
end
