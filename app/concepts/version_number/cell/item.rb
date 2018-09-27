module VersionNumber::Cell
  class Item < Trailblazer::Cell
    def number
      options[:number]
    end
  end
end
