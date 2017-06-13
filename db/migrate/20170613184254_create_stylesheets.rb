class CreateStylesheets < ActiveRecord::Migration[5.1]
  def change
    create_table :stylesheets do |t|
      t.text :content

      t.timestamps
    end
  end
end
