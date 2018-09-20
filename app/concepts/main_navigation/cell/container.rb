require 'uri'

module MainNavigation::Cell
  class Container < Trailblazer::Cell
    def model
      Category.visible.order(:position)
    end

    def current_category_id
      return nil if options[:url].nil?
      URI(options[:url]).path.scan(/\/categories\/(\d*).*/).flatten.map(&:to_i).first
    end
  end
end
