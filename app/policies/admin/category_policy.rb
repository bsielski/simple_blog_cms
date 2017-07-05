class Admin::CategoryPolicy < ApplicationPolicy

  def create?
    admin.has_role? :super_admin or admin.has_role? :can_create_categories
  end

  def update?
    admin.has_role? :super_admin or admin.has_role? :can_edit_categories
  end

  def destroy?
    admin.has_role? :super_admin or admin.has_role? :can_delete_categories
  end


end
