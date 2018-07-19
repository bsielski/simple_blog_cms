module FooterSection::Cell
  class Sections < Trailblazer::Cell
    def model
      FooterSection.order(:position)
    end
  end
end
