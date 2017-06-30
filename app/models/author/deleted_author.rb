class Author::DeletedAuthor

  def initialize(id)
    @id = id
  end

  def name
    "Unknown"
  end

  def description
    "This author was probably deleted."
  end

  def id
    @id
  end
  
end
