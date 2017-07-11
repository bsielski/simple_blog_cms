class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  private

  def clear_cache
    require 'rails/tasks'
    Rake::Task['tmp:cache:clear'].execute
  end


end
