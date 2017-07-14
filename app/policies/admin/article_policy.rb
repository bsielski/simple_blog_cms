class Admin::ArticlePolicy < ApplicationPolicy

  def create?
    admin.has_role? :super_admin or admin.has_role? :can_create_articles
  end

  def update?
    if admin.has_role? :super_admin
      return true
    elsif record.author.admin == admin
      admin.has_role? :can_edit_own_articles
    else
      admin.has_role? :"can_edit_others'_articles"
    end
  end

  def destroy?
    if admin.has_role? :super_admin
      return true
    elsif record.author.admin == admin
      admin.has_role? :can_delete_own_articles
    else
      admin.has_role? :"can_delete_others'_articles"
    end
  end

  def change_status?
    if admin.has_role? :super_admin
      return true
    elsif record.published?
      if record.author.admin == admin
        admin.has_role? :can_unpublish_own_articles
      else
        admin.has_role? :"can_unpublish_others'_articles"
      end
    elsif record.unpublished?
      if record.author.admin == admin
        admin.has_role? :can_publish_own_articles
      else
        admin.has_role? :"can_publish_others'_articles"
      end
    end
  end

end
