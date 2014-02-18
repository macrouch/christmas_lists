class AddOriginalUrlToUsers < ActiveRecord::Migration
  def change
    add_column :users, :original_url, :string
  end
end
