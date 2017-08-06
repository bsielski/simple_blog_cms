class Category < ApplicationRecord
  before_validation :squeeze_and_strip_name

  has_many :categorizations
  has_many :articles, through: :categorizations

  enum visibility: [ :visible, :invisible ]

  acts_as_list

  validates :name, length: { maximum: 56 }
  validates :name, presence: true
  validates :name, uniqueness: true

  private

  def squeeze_and_strip_name
    self.name = name.gsub("\t", " ").gsub("\n", " ").squeeze(" ").strip if self.name
  end

end
