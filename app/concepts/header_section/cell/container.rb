module HeaderSection::Cell
  class Container < Trailblazer::Cell
    def model
      HeaderSection.order(:position)
    end
    
    def root_path
      options[:root_path]
    end
  end
end
