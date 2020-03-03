class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def new?
    create?
  end

  def create?
    current_user.manager
  end


  def edit?
    update?
  end

  def update?
    record.user == user
  end
end
