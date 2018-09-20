module FooterSection::Cell
  class New < Trailblazer::Cell

    def errors
      options[:form].errors
    end

    def policy
      options[:policy]
    end
  end
end
