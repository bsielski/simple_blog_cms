module HeaderSection::Cell
  class Sections < Trailblazer::Cell
    def model
      HeaderSection.order(:position)
    end
  end
end
