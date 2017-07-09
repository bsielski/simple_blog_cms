class Admin::AuthorPolicy < ApplicationPolicy

  def create?
    admin.has_role? :super_admin
  end

  def update?
    if admin.has_role? :super_admin
      true
    elsif admin.has_role?(:can_edit_all_authors) and not record.admin.has_role?(:super_admin)
      true
    elsif admin == record.admin
      true
    else
      false
    end
  end

  def destroy?
    if admin.has_role? :super_admin
      true
    elsif admin.has_role?(:can_delete_all_authors) and not record.admin.has_role?(:super_admin)
      true
    elsif admin == record.admin
      true
    else
      false
    end
  end

end
