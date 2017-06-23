class Article < ApplicationRecord
  belongs_to :author
  has_many :categorizations
  has_many :categories, through: :categorizations
  before_validation :convert_content_to_html, on: [:create, :update]

  enum privacy: [ :visible, :invisible, :unlisted ]

  def convert_content_to_markdown
    self.content = Convert.to_markdown self.content
  end

  private

  def convert_content_to_html
    self.content = Convert.to_html self.content
  end

end
