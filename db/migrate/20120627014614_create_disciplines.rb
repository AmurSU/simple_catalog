class CreateDisciplines < ActiveRecord::Migration
  def change
    create_table :disciplines do |t|
      t.string :name
      t.timestamps
    end
    add_index :disciplines, :name, :unique => true

    change_table :addresses do |t|
      t.integer :discipline_id
    end
    add_index :addresses, :discipline_id
  end
end
