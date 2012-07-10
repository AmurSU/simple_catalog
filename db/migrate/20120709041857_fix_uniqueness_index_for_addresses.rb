class FixUniquenessIndexForAddresses < ActiveRecord::Migration
  def up
    remove_index :addresses, :url
    add_index :addresses, [:url, :discipline_id], :unique => true
  end

  def down
    remove_index :addresses, [:url, :discipline_id]
    add_index :addresses, :url, :unique => true
  end
end
