class Category < ApplicationRecord

  has_many :categorizations
  has_many :articles, through: :categorizations
  
  acts_as_list
  
  def self.default
    NonCategory.new
  end

end
