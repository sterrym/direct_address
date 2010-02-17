
begin 
	require File.dirname(__FILE__) + '/../../config/environment.rb'

	namespace :direct_address do
		desc "pulls up to date country and region data from geonames.org"
  	task :pull do
			Geoname.retrieve_to_db
		end
	end
rescue
	puts "Direct address harvester not properly installed"
end