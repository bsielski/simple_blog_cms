class Author::GuaranteedAuthor

  def self.find(id)
    Author.find(id) || DeletedAuthor.new
  end

end
