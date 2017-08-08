class Site < ApplicationRecord
  belongs_to :stylesheet
  after_save :cache_settings, :clear_cache

  before_validation :squeeze_and_strip_title, :squeeze_and_strip_author,
    :squeeze_and_strip_description

  validates :title, length: { maximum: 56 }
  validates :title, presence: true

  validates :author, length: { maximum: 56 }

  validates :description, length: { in: 1..150, allow_nil: true }

  private

  def cache_settings
    Settings.set_all
  end

  def squeeze_and_strip_title
    self.title = title.gsub("\t", " ").gsub("\n", " ").squeeze(" ").strip if self.title
  end

  def squeeze_and_strip_author
    self.author = author.gsub("\t", " ").gsub("\n", " ").squeeze(" ").strip if self.author
  end

  def squeeze_and_strip_description
    self.description = description.gsub("\t", " ").gsub("\n", " ").squeeze(" ").strip if self.description
  end

end
