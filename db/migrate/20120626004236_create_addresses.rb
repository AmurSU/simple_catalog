class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :url
      t.string :domain
      t.timestamps
    end
    add_index :addresses, :url, :unique => true
  end
end
