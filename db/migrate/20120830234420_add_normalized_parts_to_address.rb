class AddNormalizedPartsToAddress < ActiveRecord::Migration
  def up
    add_column :addresses, :normalized_url, :string
    add_column :addresses, :normalized_domain, :string
    
    say_with_time "Generating normalized parts of addresses, this could take a while" do
      Address.find_each do |address|
        address.generate_normalized_url!
        address.generate_normalized_domain!
        address.save
      end
    end
  end

  def down
    remove_column :addresses, :normalized_url
    remove_column :addresses, :normalized_domain
  end
end
