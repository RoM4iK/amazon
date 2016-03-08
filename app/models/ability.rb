class Ability
  include CanCan::Ability
  def initialize(user)
    can :read, Book
    can :read, Category
    can :read, Author
    
    if user && user.admin?
      can :access, :rails_admin
      can :dashboard
      can :manage, :all
    end
  end
end