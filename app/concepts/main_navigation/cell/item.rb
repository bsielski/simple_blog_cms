module MainNavigation::Cell
  class Item < Trailblazer::Cell
    include ActiveLinkTo
    property :name
    property :id

    private
    
    def link
      link_to name, path, class: classes
    end

    def classes
      return "main_navigation__link main_navigation__link--active" if active?
      "main_navigation__link"
    end
    
    def active?
      return false unless options[:current_category_id]
      return false unless id == options[:current_category_id]
      true
    end

    def path
      Rails.application.routes.url_helpers.category_articles_path(model)
    end
  end
end
