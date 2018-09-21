module PageHeadline::Cell
  class Item < Trailblazer::Cell
    def text
      options[:text]
    end
  end
end
