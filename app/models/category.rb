class Category < ApplicationRecord
  before_validation :squeeze_and_strip_name, :squeeze_and_strip_description

  has_many :categorizations
  has_many :articles, through: :categorizations

  enum visibility: [ :visible, :invisible ]

  acts_as_list

  validates :name, length: { maximum: 56 }
  validates :name, presence: true
  validates :name, uniqueness: true

  validates :description, length: { in: 0..512, allow_nil: false }

  private

  def squeeze_and_strip_name
    self.name = name.gsub("\t", " ").gsub("\n", " ").squeeze(" ").strip if self.name
  end

  def squeeze_and_strip_description
    self.description = description.gsub("\t", " ").gsub("\n", " ").squeeze(" ").strip if self.description
  end


end
