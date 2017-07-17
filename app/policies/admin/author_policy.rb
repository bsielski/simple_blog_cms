class Admin::AuthorPolicy < ApplicationPolicy

  def create?
    if admin.has_role? :super_admin
      true
    elsif not record.admin.has_role?(:super_admin)
      if admin.has_role?(:"can_create_others'_authors") and admin != record.admin
        true
      elsif admin.has_role?(:"can_create_own_authors") and admin == record.admin
        true
      end
    end
  end

  def update?
    if admin.has_role? :super_admin
      true
    elsif not record.admin.has_role?(:super_admin)
      if admin.has_role?(:"can_edit_others'_authors") and admin != record.admin
        true
      elsif admin.has_role?(:"can_edit_own_authors") and admin == record.admin
        true
      end
    end
  end

  def destroy?
    if admin.has_role? :super_admin
      true
    elsif not record.admin.has_role?(:super_admin)
      if admin.has_role?(:"can_delete_others'_authors") and admin != record.admin
        true
      elsif admin.has_role?(:"can_delete_own_authors") and admin == record.admin
        true
      end
    end
  end

end
