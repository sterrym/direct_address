class DirectAddressGenerator < Rails::Generator::Base
  def manifest
    record do |m|
		
			m.directory "lib/direct_address"
			
			%w(address country region).each do |model|
				m.file "models/#{model}.rb", "app/models/#{model}.rb"
			end
			
			%w(addresses countries regions).each do |migrate|
				m.migration_template "migrations/create_#{migrate}.rb", "db/migrate", {:migration_file_name => "direct_address_create_#{migrate}"}
			end
			
			m.file "tasks/harvest.rake", "lib/tasks/direct_address_harvest.rake"
		end
	end
end