class CreateSubGroups < ActiveRecord::Migration
  def change
    create_table :sub_groups do |t|
      t.integer :group_id
      t.timestamps null: false
    end
  end
end
