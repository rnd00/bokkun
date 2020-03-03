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
    record.user == user
  end

  def update?
    record.user == user
  end
end
