class AddHiddenFromOwnerToItems < ActiveRecord::Migration
  def up
    rename_column :items, :visible_to_owner, :hidden_from_owner
    change_column :items, :hidden_from_owner, :boolean, default: false
  end

  def down
    rename_column :items, :hidden_from_owner, :visible_to_owner
    change_column :items, :visible_to_owner, :boolean, default: true
  end
end
