module FooterSection::Cell
  class Delete < Trailblazer::Cell

    def page_headline_text
      "Delete footer section: #{model.position}"
    end

    def markdown_content
      model.convert_content_to_markdown
    end
  end
end
