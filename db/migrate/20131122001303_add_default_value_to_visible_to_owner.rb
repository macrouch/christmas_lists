class AddDefaultValueToVisibleToOwner < ActiveRecord::Migration
  def up
    change_column :items, :visible_to_owner, :boolean, default: true
  end
  
  def down
    change_column :items, :visible_to_owner, :boolean, default: nil
  end
end
