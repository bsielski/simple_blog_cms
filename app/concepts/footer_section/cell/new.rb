module FooterSection::Cell
  class New < Trailblazer::Cell

    def page_headline_text
      "New footer section"
    end

    def errors
      options[:form].errors
    end
  end
end
