class Author < ApplicationRecord
  belongs_to :admin
  has_many :articles

  def not_deleted?
    true
  end
  
end
