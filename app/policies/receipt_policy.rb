class ReceiptPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    record.user == user || user.manager
  end

  def new?
    create?
  end

  def create?
    record.trip.users.include?(user) || user.manager
  end

  def update?
    record.user == user || user.manager
  end

  def edit?
    update?
  end

  def destroy?
    record.user == user || user.manager
  end
end
