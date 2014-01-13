class CreateItemComments < ActiveRecord::Migration
  def change
    create_table :item_comments do |t|
      t.string :comment
      t.integer :item_id
      t.integer :user_id
      t.boolean :private, default: false

      t.timestamps
    end
  end
end
