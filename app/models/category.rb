class Category < ApplicationRecord
  has_many :categorizations
  has_many :articles, through: :categorizations

  def self.default
    NonCategory.new
  end

end
