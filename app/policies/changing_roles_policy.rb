class ChangingRolesPolicy < ApplicationPolicy

  def change_roles?
    tests_results = []
    if admin.has_role? :super_admin
      return true
    else
      record.roles_to_give.each do |role_to_give|
        return false unless admin.has_all_roles? role_to_give, :can_give_roles
      end
      record.roles_to_take_away.each do |role_to_take_away|
        return false unless admin.has_all_roles? role_to_take_away, :can_take_away_roles
      end
    end
    true
  end

end
