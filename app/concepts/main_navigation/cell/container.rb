module MainNavigation::Cell
  class Container < Trailblazer::Cell
    def model
      Category.visible.order(:position)
    end
  end
end
