class Admin::HeaderSectionPolicy < ApplicationPolicy

  def create?
    admin.has_role? :super_admin or admin.has_role? :can_create_header_sections
  end

  def update?
    admin.has_role? :super_admin or admin.has_role? :can_edit_header_sections
  end

  def destroy?
    admin.has_role? :super_admin or admin.has_role? :can_delete_header_sections
  end

end
