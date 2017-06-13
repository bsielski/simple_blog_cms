class CreateSites < ActiveRecord::Migration[5.1]
  def change
    create_table :sites do |t|
      t.string :title
      t.string :author
      t.string :keywords
      t.text :description
      t.references :stylesheet, foreign_key: true

      t.timestamps
    end
  end
end
