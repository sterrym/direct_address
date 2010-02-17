class DirectAddressGenerator < Rails::Generator::Base
  def manifest
    record do |m|
		
			m.directory "lib/direct_address"
			
			%w(address country region).each do |model|
				m.file "models/#{model}.rb", "app/models/#{model}.rb"
			end
			
			m.migration_template "migrations/direct_address_migration.rb", "db/migrate", {:migration_file_name => "direct_address_migration"}
			
			m.file "tasks/harvest.rake", "lib/tasks/direct_address_harvest.rake"
		end
	end
end