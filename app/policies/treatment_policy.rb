class TreatmentPolicy < ApplicationPolicy

  def create?
    user.admin? || (user.vet? && record.appointment.vet == user.vet)
  end

  def update?
    create?
  end

  def destroy?
    user.admin?
  end
end