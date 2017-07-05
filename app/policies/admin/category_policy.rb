class Admin::CategoryPolicy < ApplicationPolicy

  def create?
    admin.has_role? :super_admin
  end

  def update?
    admin.has_role? :super_admin
  end

  def destroy?
    admin.has_role? :super_admin
  end


end
