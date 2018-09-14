module HeaderSection::Cell
  class Item < Trailblazer::Cell
    def content
      model.content.html_safe
    end

    def root_path
      options[:root_path]
    end
  end
end
