class Author::DeletedAuthor

  class FakeAdmin < Struct.new(:email)
  end

  def initialize(id)
    @id = id
  end

  def name
    "Unknown"
  end

  def admin
    FakeAdmin.new("no email")
  end
  
  def description
    "This author was probably deleted."
  end

  def id
    @id
  end
  
end
