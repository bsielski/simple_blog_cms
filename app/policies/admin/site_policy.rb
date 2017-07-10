class Admin::SitePolicy < ApplicationPolicy

  def update?
    if admin.has_role? :super_admin
      true
    elsif admin.has_role? :can_edit_site_settings
      true
    end
  end

end
