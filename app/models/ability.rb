class Ability
  include CanCan::Ability

  def initialize(user)
    can [:show], Product
    if user.present?
      if user.admin?
        can :manage, :all
      else
        can [:show, :edit, :update], User
        can [:index, :new, :create, :destroy], Order
        can [:index, :show], Category
      end
    end
  end
end
