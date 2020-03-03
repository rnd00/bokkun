class TripPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    record.user == user || user.manager
  end

  def export?
    record.user == user || user.manager
  end
end
