class Article < ApplicationRecord
  belongs_to :author
  has_many :categorizations
  has_many :categories, through: :categorizations
  before_validation :convert_content_to_html, on: [:create, :update]
  before_create :set_status_to_unpublished
  after_create :handle_publishing_time
  around_update :handle_publishing_stuff
  enum status: [ :unpublished, :published ]

  def convert_content_to_markdown
    self.content = Convert.to_markdown self.content
  end

  def author
    super || Author::DeletedAuthor.new(self.author_id)
  end

  def get_not_published_description
    if self.published_at
      return "withdrawn"
    else
      return "never published"
    end
  end

  def substatus
    result = status
    if result == "unpublished"
      return get_not_published_description
    else
      return result
    end
  end

  private

  def set_status_to_unpublished
    self.status = "unpublished"
  end

  def handle_publishing_stuff
    old_status = Article.find(self.id).status
    yield
    if (old_status == "unpublished" or old_status == nil) and self.status == "published"
      self.published_at = self.updated_at
      self.save!
    end

  end

  def convert_content_to_html
    self.content = Convert.to_html self.content
  end

  def handle_publishing_time
    if self.published?
      self.update published_at: self.created_at
    end
  end

end
