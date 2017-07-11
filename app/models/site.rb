class Site < ApplicationRecord
  belongs_to :stylesheet
  after_save :cache_settings, :clear_cache

  private

  def cache_settings
    Settings.set_all
  end

end
