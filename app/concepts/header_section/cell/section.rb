module HeaderSection::Cell
  class Section < Trailblazer::Cell
    def content
      model.content.html_safe
    end
  end
end
