module MainNavigation::Cell
  class Item < Trailblazer::Cell
    include ActiveLinkTo
    
    property :name

    private
    
    def link
      active_link_to name, category_articles_path(model), class: "main_navigation__link", class_active: "main_navigation__link--active", active: :inclusive
    end
  end
end
