class Site < ApplicationRecord
  belongs_to :stylesheet
  after_save :cache_settings


  private

  def cache_settings
    Settings.set_all
  end

end
