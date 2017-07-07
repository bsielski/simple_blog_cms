class Category < ApplicationRecord

  has_many :categorizations
  has_many :articles, through: :categorizations

  enum privacy: [ :visible, :invisible ]

  acts_as_list



end
