class AddNameToStylesheet < ActiveRecord::Migration[5.1]
  def change
    add_column :stylesheets, :name, :string
  end
end
