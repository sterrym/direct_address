
begin 
	
	namespace :direct_address do
		desc "pulls up to date country and region data from geonames.org"
  	task :seed do
			require File.join(File.dirname(__FILE__),'..','..','config','boot')
			Rails::Initializer.run do |config|
				config.gem 'direct_address', :version => '>=0.0.7'
			end
			Geoname.retrieve_to_db
		end
	end
	
rescue
	puts "Direct address harvester not properly installed"
end