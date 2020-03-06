class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    user.manager
  end

  def new?
    user.manager
  end

  def dashboard?
    true
  end


  def edit?
    record == user
  end

  def update?
    record == user
  end

  def show?
    record == user || user.manager
  end
end
