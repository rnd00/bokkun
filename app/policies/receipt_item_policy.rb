class ReceiptItemPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def new?
    create?
  end

  def create?
    record.receipt.user == user || user.manager
  end

  def edit?
    update?
  end

  def update?
    record.receipt.user == user || user.manager
  end

  def destroy?
    record.receipt.user == user || user.manager
  end
end
