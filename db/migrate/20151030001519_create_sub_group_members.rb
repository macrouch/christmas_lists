class CreateSubGroupMembers < ActiveRecord::Migration
  def change
    create_table :sub_group_members do |t|
      t.integer :sub_group_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
