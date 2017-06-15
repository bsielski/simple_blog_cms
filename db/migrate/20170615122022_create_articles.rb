class CreateArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :articles do |t|
      t.string :title
      t.integer :privace
      t.text :content
      t.string :url_title
      t.references :author, foreign_key: true

      t.timestamps
    end
  end
end
