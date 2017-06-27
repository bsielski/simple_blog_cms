class Stylesheet < ApplicationRecord
  after_save :clear_cache
  has_one :site


  private

  def clear_cache
    require 'rails/tasks'
    Rake::Task['tmp:cache:clear'].execute
  end
  

end
