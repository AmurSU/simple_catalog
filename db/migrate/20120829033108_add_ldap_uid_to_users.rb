class AddLdapUidToUsers < ActiveRecord::Migration
  def change
    add_column :users, :uid, :string
    add_column :users, :name, :string
    add_index  :users, :uid, :unique => true
  end
end
