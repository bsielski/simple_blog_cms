class Admin::SitePolicy < ApplicationPolicy

  def update?
    if admin.has_role? :super_admin
      true
    elsif admin.has_role? :can_edit_site_settings
      true
    end
  end

  def change_stylesheet
    if admin.has_role? :super_admin
      true
    elsif admin.has_role? :can_activate_stylesheets
      true
    end
  end


end
