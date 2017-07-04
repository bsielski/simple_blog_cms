class Article < ApplicationRecord
  belongs_to :author
  has_many :categorizations
  has_many :categories, through: :categorizations
  before_validation :convert_content_to_html, on: [:create, :update]

  enum status: [ :unpublished, :published, :unlisted ]

  def convert_content_to_markdown
    self.content = Convert.to_markdown self.content
  end

  def author
    super || Author::DeletedAuthor.new(self.author_id)
  end

  private

  def convert_content_to_html
    self.content = Convert.to_html self.content
  end

end
