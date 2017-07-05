class Admin::FooterSectionPolicy < ApplicationPolicy

  def create?
    admin.has_role? :super_admin or admin.has_role? :can_create_footer_sections
  end

  def update?
    admin.has_role? :super_admin or admin.has_role? :can_edit_footer_sections
  end

  def destroy?
    admin.has_role? :super_admin or admin.has_role? :can_delete_footer_sections
  end

end
