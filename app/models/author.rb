class Author < ApplicationRecord
  belongs_to :admin
  has_many :articles

  def name_with_id
    self.name + " (admin id: #{self.admin_id})"
  end
  
  def not_deleted?
    true
  end
  
end
