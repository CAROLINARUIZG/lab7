class AppointmentPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      if user.admin?
        scope.all
      elsif user.vet?
        scope.where(vet: user.vet)
      elsif user.owner?
        scope.joins(:pet).where(pets: { owner_id: user.owner.id })
      else
        scope.none
      end
    end
  end

  def index?
    true
  end

  def show?
    user.admin? || 
    (user.vet? && record.vet == user.vet) || 
    (user.owner? && record.pet.owner == user.owner)
  end

  def new?
    create?
  end

  def create?
    user.admin? || user.owner?
  end

  def update?
    show? 
  end

  def destroy?
    user.admin? || 
    (user.owner? && record.pet.owner == user.owner) ||
    (user.vet? && record.vet == user.vet)
  end

  def permitted_attributes
      [:date, :reason, :status, :pet_id, :vet_id]
  end
end