class CreateListItems < ActiveRecord::Migration
  def change
    create_table :list_items do |t|
      t.integer :item_id
      t.integer :list_id
      t.boolean :visible_to_owner
      t.boolean :purchased
      t.string :purchased_by

      t.timestamps
    end
  end
end
