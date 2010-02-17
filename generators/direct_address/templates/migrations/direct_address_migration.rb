class DirectAddressMigration < ActiveRecord::Migration
  def self.up
    create_table :regions do |t|
			t.references :country
			t.string :name
			t.timestamps
		end
		
		add_index :regions, :country_id
  end

  def self.down
    drop_table :regions
  end
end
