ActiveRecord::Schema.define :version => 0 do
  
	create_table :addresses, :force => true do |t|
		t.references :addressable, :polymorphic => true, :null => false
		t.references :country
		t.references :region
		t.string :street1
		t.string :street2
		t.string :city
		t.string :postal
		t.timestamps
	end
	
	create_table :countries, :force => true do |t|
		t.string :abbreviation
		t.string :name
		t.timestamps
	end
	
	create_table :regions, :force => true do |t|
		t.references :country
		t.string :name
		t.timestamps
	end
	
	create_table :users, :force => true do |t|
		t.string :name
		t.timestamps
	end
  
end