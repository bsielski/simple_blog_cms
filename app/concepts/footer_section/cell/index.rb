module FooterSection::Cell
  class Index < Trailblazer::Cell

    def page_headline_text
      "Manage footer section"
    end

    def link_to_create_new_footer_section
      link_to(
        'Create a new footer section',
        new_admin_footer_section_path
      ) if can_create?
    end

    def can_create?
      options[:policy].create?
    end
    def can_update?
      options[:policy].update?
    end
    def can_destroy?
      options[:policy].destroy?
    end
  end
end
