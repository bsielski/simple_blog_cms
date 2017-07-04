class RenamePrivacyToStatusInArticles < ActiveRecord::Migration[5.1]
  def change
    rename_column :articles, :privacy, :status
  end
end
