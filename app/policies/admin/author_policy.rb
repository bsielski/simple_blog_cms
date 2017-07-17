class Admin::AuthorPolicy < ApplicationPolicy

  class Scope
    attr_reader :admin, :scope

    def initialize(admin, scope)
      @admin  = admin
      @scope = scope.is_a?(Array) ? scope.last : scope
    end

    def resolve
      if @admin.has_role? :"super_admin"
        scope.all
      elsif @admin.has_any_role? :"can_edit_others'_authors", :"can_delete_others'_authors"
        #scope.where.not(admin_id: Admin.with_role(:super_admin).pluck(admins: :id))
        scope.where("admin_id NOT IN (?)", Admin.with_role(:super_admin).ids)
      else
        scope.where(admin: @admin)
      end
    end

  end

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
