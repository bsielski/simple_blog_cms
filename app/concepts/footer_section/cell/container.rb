module FooterSection::Cell
  class Container < Trailblazer::Cell
    def model
      FooterSection.order(:position)
    end
  end
end
