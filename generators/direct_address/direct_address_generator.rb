class DirectAddressGenerator < Rails::Generator::Base
  def manifest
    record do |m|
			
			m.file "js/country_select.js", "public/javascripts/country_select.js"
			
			m.directory "app/views/regions"
			m.file "views/index.json.erb", "app/views/regions/index.json.erb"
			
			m.file "controllers/regions_controller.rb", "app/controllers/regions_controller.rb"
			
			%w(address country region).each do |model|
				m.file "models/#{model}.rb", "app/models/#{model}.rb"
			end
			
			m.route_resources :regions
			
			m.migration_template "migrations/direct_address_migration.rb", "db/migrate", {:migration_file_name => "direct_address_migration"}
			
			m.director "lib/tasks"
			m.file "tasks/harvest.rake", "lib/tasks/direct_address_harvest.rake"
			
		end
	end
end