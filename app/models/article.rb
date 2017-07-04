class Article < ApplicationRecord
  belongs_to :author
  has_many :categorizations
  has_many :categories, through: :categorizations
  before_validation :convert_content_to_html, on: [:create, :update]
  after_create :handle_publishing_time
  enum status: [ :unpublished, :published ]

  def convert_content_to_markdown
    self.content = Convert.to_markdown self.content
  end

  def author
    super || Author::DeletedAuthor.new(self.author_id)
  end

  def get_not_published_description
    if self.published_at
      "withdrawn"
    else
      "unpublished"
    end
  end

  def substatus
    result = status
    if result == "unpublished"
      return get_not_published_description
    else
      result
    end
  end

  private

  def convert_content_to_html
    self.content = Convert.to_html self.content
  end

  def handle_publishing_time
    if self.published?
      self.update published_at: self.created_at
    end
  end

end
