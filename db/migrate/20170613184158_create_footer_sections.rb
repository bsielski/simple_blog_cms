class CreateFooterSections < ActiveRecord::Migration[5.1]
  def change
    create_table :footer_sections do |t|
      t.text :content
      t.integer :position

      t.timestamps
    end
  end
end
