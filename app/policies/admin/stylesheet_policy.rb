class Admin::StylesheetPolicy < ApplicationPolicy

  def create?
    admin.has_role? :super_admin or admin.has_role? :can_create_stylesheets
  end

  def update?
    admin.has_role? :super_admin or admin.has_role? :can_edit_stylesheets
  end

  def destroy?
    admin.has_role? :super_admin or admin.has_role? :can_delete_stylesheets
  end

end
