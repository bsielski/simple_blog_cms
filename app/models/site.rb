class Site < ApplicationRecord
  belongs_to :stylesheet
  after_save :cache_settings, :clear_cache

  before_validation :squeeze_and_strip_title, :squeeze_and_strip_author

  validates :title, length: { maximum: 56 }
  validates :title, presence: true

  validates :author, length: { maximum: 56 }

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

end
