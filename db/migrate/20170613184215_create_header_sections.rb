class CreateHeaderSections < ActiveRecord::Migration[5.1]
  def change
    create_table :header_sections do |t|
      t.text :content
      t.integer :position

      t.timestamps
    end
  end
end
