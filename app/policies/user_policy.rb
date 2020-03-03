class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    current_user.manager
  end

  def new?
    current_user.manager
  end

  def edit?
    current_user == user
  end

  def update?
    current_user == user
  end
end
