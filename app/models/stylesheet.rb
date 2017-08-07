class Stylesheet < ApplicationRecord
  after_save :clear_cache
  has_one :site

  before_validation :squeeze_and_strip_name

  validates :name, length: { maximum: 56 }
  validates :name, presence: true
  validates :name, uniqueness: true

  private

  def squeeze_and_strip_name
    self.name = name.gsub("\t", " ").gsub("\n", " ").squeeze(" ").strip if self.name
  end

end
