class ArticlePolicy < ApplicationPolicy

  def show?
    if record.unpublished?
      admin.has_role? :super_admin or admin.has_role? :"can_read_others'_unpublished_articles"
    else
      true
    end
  end

end
