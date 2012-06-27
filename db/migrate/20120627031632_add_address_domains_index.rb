class AddAddressDomainsIndex < ActiveRecord::Migration
  def change
    add_index :addresses, :domain
  end
end
