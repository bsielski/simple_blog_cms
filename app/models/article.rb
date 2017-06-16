class Article < ApplicationRecord
  belongs_to :author
  has_many :categorizations
  has_many :categories, through: :categorizations
end
