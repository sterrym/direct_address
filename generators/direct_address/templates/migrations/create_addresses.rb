class CreateAddresses < ActiveRecord::Migration
  def self.up
    create_table :addresses do |t|
			t.references :addressable, :polymorphic => true, :null => false
			t.references :country
			t.references :region
			t.string :street1
			t.string :street2
			t.string :city
			t.string :postal
			t.timestamps
		end
		
		add_index :addresses, [:addressable_id, :addressable_type]
		add_index :addresses, [:country_id]
		add_index :addresses, [:region_id]
		
  end

  def self.down
    drop_table :addresses
  end
end
