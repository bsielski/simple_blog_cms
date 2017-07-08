class AddDescriptionToAuthors < ActiveRecord::Migration[5.1]
  def change
    add_column :authors, :description, :text
  end
end
