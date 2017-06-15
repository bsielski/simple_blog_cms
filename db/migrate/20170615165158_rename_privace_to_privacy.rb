class RenamePrivaceToPrivacy < ActiveRecord::Migration[5.1]
  def change
    rename_column :articles, :privace, :privacy
  end
end
