class Admin::AdminPolicy < ApplicationPolicy

  def change_email?
    if admin != record
      if admin.has_any_role? :super_admin, :"can_edit_admins'_emails"
        unless record.has_role? :super_admin
          true
        end
      end
    end
  end

  def change_roles?
    if admin == record
      return false
    else
      return true
    end
  end

  def destroy?
    if admin != record
      if admin.has_any_role? :super_admin, :can_delete_admins
        unless record.has_role? :super_admin
          true
        end
      end
    end
  end

end
