class CreateCollections < ActiveRecord::Migration
  def change
    create_table :collections do |t|
      t.integer :group_id
      t.string :name

      t.timestamps
    end
  end
end
