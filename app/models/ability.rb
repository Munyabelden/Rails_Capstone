class Ability
  include CanCan::Ability

  def initialize(user)

    if user.present?

      can :read, Recipe, user_id: user.id
      can :create, Recipe, user_id: user.id
      can :destroy, Recipe, user_id: user.id

      can :read, Recipe, public: true

      can :update_public_status, Recipe, user_id: user.id
      can :read, Recipe, public: true

      if user.group.users.count < 3
        can :read, Food, user_id: user.id
      end
    end
  end
end
