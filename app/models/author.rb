class Author < ApplicationRecord
  belongs_to :admin
  has_many :articles
end
