class Stylesheet < ApplicationRecord
  after_save :clear_cache
  has_one :site

  def activate
    Site.first.update(stylesheet: self)
    clear_cache
  end

  private

  def clear_cache
    require 'rails/tasks'
    Rake::Task['tmp:cache:clear'].execute
  end
  

end
