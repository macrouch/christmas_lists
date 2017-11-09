class CreateUserNotifications < ActiveRecord::Migration
  def change
    create_table :user_notifications do |t|
      t.integer :user_id
      t.integer :notification_id
      t.boolean :is_read, default: false

      t.timestamps null: false
    end
  end
end
