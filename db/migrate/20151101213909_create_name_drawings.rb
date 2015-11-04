class CreateNameDrawings < ActiveRecord::Migration
  def change
    create_table :name_drawings do |t|
      t.integer :collection_id
      t.integer :picker_id
      t.integer :receiver_id

      t.timestamps null: false
    end
  end
end
