namespace :direct_address => :environment do
	desc "pulls up to date country and region data from geonames.org"
	task :seed do
		Geoname.retrieve_to_db
	end
end
