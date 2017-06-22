class Article < ApplicationRecord
  belongs_to :author
  has_many :categorizations
  has_many :categories, through: :categorizations
  before_validation :convert_content_to_html, on: [:create, :update]



  private

  def convert_content_to_html
    self.content = Convert.to_html self.content
  end

end
