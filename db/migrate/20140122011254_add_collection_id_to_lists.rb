class AddCollectionIdToLists < ActiveRecord::Migration
  def change
    add_column :lists, :collection_id, :integer
  end
end
