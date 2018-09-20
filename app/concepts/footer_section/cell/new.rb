module FooterSection::Cell
  class New < Trailblazer::Cell

    def errors
      options[:form].errors
    end

    def creating_policy
      options[:creating_policy]
    end

    def updating_policy
      options[:updating_policy]
    end

    def destroying_policy
      options[:destroying_policy]
    end
  end
end
