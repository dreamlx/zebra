class Ability
  include CanCan::Ability

  def initialize(admin)
    alias_action :create, :read, :update, :destroy, :to => :crud

    # if user.state == "通过"
    #   can :manage, :all
    # elsif user.state == "否决"
    #   cannot :read, :all
    # else
    #   can :read, :all
    # end

    # Define abilities for the passed in user here. For example:

    admin ||= Admin.new # guest user (not logged in)
    if admin.role == "admin"
      can :manage, :all
    elsif admin.state == "通过"
      can :create,                                               Admin
      can [:show, :update],                                      Admin,    id: admin.id
      can [:read, :create, :update, :destroy],                   User
      can :create,                                               Product
      can [:read, :update, :destroy,:create_multiple],           Product,  admin_id: admin.id
      can [:read, :create, :update, :destroy],                   Serial
    else
      can :create,                                               Admin
      can [:show, :update],                                      Admin,    id: admin.id
    end

    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
