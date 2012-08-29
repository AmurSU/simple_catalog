class RemoveDatabaseAuthenticationFromUsers < ActiveRecord::Migration
  def up
    remove_index  :users, :reset_password_token
    remove_column :users, :reset_password_token
    remove_column :users, :reset_password_sent_at
    remove_column :users, :encrypted_password
  end

  def down
    add_column :users, :encrypted_password, :null => false, :default => ""
    add_column :users, :reset_password_sent_at, :datetime
    add_column :users, :reset_password_token, :string
    add_index  :users, :reset_password_token, :unique => true
  end
end
