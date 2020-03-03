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
end
