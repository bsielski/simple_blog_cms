module FooterSection::Cell
  class Item < Trailblazer::Cell
    def content
      model.content.html_safe
    end
  end
end
