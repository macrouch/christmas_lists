class CreateFamilyMembers < ActiveRecord::Migration
  def change
    create_table :family_members do |t|
      t.integer :family_id
      t.integer :user_id

      t.timestamps
    end
  end
end
