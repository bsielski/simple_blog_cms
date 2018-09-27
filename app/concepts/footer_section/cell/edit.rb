module FooterSection::Cell
  class Edit < Trailblazer::Cell

    def errors
      options[:form].errors
    end

    def page_headline_text
      "Edit footer section: #{model.position}"
    end

    def policy
      options[:policy]
    end

    def can_destroy
      options[:policy].destroy?
    end
  end
end
