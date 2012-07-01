class CreateSectors < ActiveRecord::Migration
  def change
    create_table :sectors do |t|
      t.string :name
      t.timestamps
    end
    add_index :sectors, :name, :unique => true

    change_table :disciplines do |t|
      t.references :sector
    end
    add_index :disciplines, :sector_id
  end
end
