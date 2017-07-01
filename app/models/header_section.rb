class HeaderSection < ApplicationRecord

  before_validation :convert_content_to_html, on: [:create, :update]

  def convert_content_to_markdown
    self.content = Convert.to_markdown self.content
  end
  
  private

  def convert_content_to_html
    self.content = Convert.to_html self.content
  end


end
