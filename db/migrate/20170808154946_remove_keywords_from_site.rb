class RemoveKeywordsFromSite < ActiveRecord::Migration[5.1]
  def change
    remove_column :sites, :keywords, :string
  end
end
