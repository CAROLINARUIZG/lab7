class OwnerPolicy < ApplicationPolicy

  class Scope < ApplicationPolicy::Scope
    def resolve
      if user.admin? || user.vet?
        scope.all
      elsif user.owner?
        scope.where(user_id: user.id)
      else
        scope.none
      end
    end
  end

  def show?
    user.admin? || user.vet? || record.user_id == user.id
  end

  def update?
    user.admin? || record.user_id == user.id
  end

  def create?
    user.admin?
  end

  def destroy?
    user.admin?
  end
end