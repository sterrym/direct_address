class DirectAddressMigration < ActiveRecord::Migration
  def self.up
    create_table :regions do |t|
			t.references :country
			t.string :name
			t.timestamps
		end
		
		add_index :regions, :country_id
		
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

		create_table :countries do |t|
		  t.string :abbreviation
		  t.string :name
		  t.timestamps
		end
		
  end

  def self.down
    drop_table :regions
		drop_table :countries
		drop_table :addresses
  end
end
