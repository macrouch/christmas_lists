class AddFieldsToItems < ActiveRecord::Migration
  def change
    add_column :items, :list_id, :integer
    add_column :items, :visible_to_owner, :boolean
    add_column :items, :purchased, :boolean
    add_column :items, :purchased_by, :string
  end
end
