module HeaderSection::Cell
  class Container < Trailblazer::Cell
    def model
      HeaderSection.order(:position)
    end
  end
end
