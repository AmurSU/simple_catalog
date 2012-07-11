class CreateZones < ActiveRecord::Migration
  def change
    create_table :zones do |t|
      t.string :suffix
      t.string :description

      t.timestamps
    end
    add_index :zones, :suffix, :unique => true
  end
end
