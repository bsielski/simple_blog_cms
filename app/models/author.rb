class Author < ApplicationRecord
  belongs_to :admin
  before_validation :convert_description_to_html, on: [:create, :update]
  has_many :articles

  def name_with_id
    self.name + " (admin id: #{self.admin_id})"
  end

  def convert_description_to_markdown
    self.description = Convert.to_markdown self.description
  end

  def not_deleted?
    true
  end

  private

  def convert_description_to_html
    self.description = Convert.to_html self.description
  end

end
