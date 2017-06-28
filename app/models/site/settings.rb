class Site::Settings

  @@title = nil
  @@author = nil
  @@keywords = nil
  @@description = nil
  
  def self.set_title
    @@title = Site.first.title
    @@title
  end

  def self.set_author
    @@author = Site.first.author
    @@author
  end

  def self.set_keywords
    @@keywords = Site.first.keywords
    @@keywords
  end

    def self.set_description
    @@description = Site.first.description
    @@description
  end
  
  def self.set_all
    set_title
    set_author
    set_keywords
    set_description
  end
  
  def self.title
    @@title || set_title
  end

  def self.author
    @@author || set_author
  end

  def self.keywords
    @@keywords || set_keywords
  end

  def self.description
    @@description || set_description
  end
      
end
