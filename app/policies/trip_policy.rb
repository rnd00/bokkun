class TripPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    record.users.include?(user) || user.manager
  end

  def export?
    record.users.include?(user) || user.manager
  end

  def new?
    create?
  end

  def create?
    user.manager
  end

  def edit?
    update?
  end

  def update?
    record.users.include?(user) || user.manager
  end

  def destroy?
    user.manager
  end

  def report?
    user.manager
  end
end
