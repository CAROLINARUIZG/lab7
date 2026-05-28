class PetPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      if user.admin? || user.vet?
        scope.all
      elsif user.owner?
        user.owner.present? ? scope.where(owner: user.owner) : scope.none
      else
        scope.none
      end
    end
  end

  def show?
    user.admin? || user.vet? || record.owner.user_id == user.id
  end

  def create?
    user.admin? || user.owner?
  end

  def update?
    show?
  end

  def destroy?
    user.admin? || (user.owner? && record.owner.user_id == user.id)
  end

  def permitted_attributes
    if user.admin?
      [:name, :species, :breed, :birth_date, :owner_id] 
    else
      [:name, :species, :breed, :birth_date] 
    end
  end
end