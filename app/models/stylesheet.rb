class Stylesheet < ApplicationRecord
  after_save :clear_cache
  has_one :site


end
