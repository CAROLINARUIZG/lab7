class VetPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      if user.admin? || user.vet?
        scope.all
      else
        scope.all
      end
    end
  end

  def index?
    true
  end

  def show?
    true
  end

  def update?
    user.admin? || (user.vet? && record.user_id == user.id)
  end

  def edit?
    update?
  end

  def create?
    user.admin?
  end

  def destroy?
    user.admin?
  end
end