class Category::NonCategory
  attr_reader :name, :description
  
  def initialize
    @name = "All articles"
    @description = "No category selected"
  end

end
