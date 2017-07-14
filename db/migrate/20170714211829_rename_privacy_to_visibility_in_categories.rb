class RenamePrivacyToVisibilityInCategories < ActiveRecord::Migration[5.1]
  def change
    rename_column :categories, :privacy, :visibility
  end
end
