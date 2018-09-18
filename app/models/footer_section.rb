class FooterSection < ApplicationRecord

  acts_as_list
  
  def convert_content_to_markdown
    self.content = Convert.to_markdown self.content
  end
end
