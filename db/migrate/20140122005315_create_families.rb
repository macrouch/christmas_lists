class CreateFamilies < ActiveRecord::Migration
  def change
    create_table :families do |t|
      t.string :name
      t.string :question
      t.string :answer
      t.integer :user_id

      t.timestamps
    end
  end
end
