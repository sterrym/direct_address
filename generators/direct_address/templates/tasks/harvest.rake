namespace :direct_address do
	desc "pulls up to date country and region data from geonames.org"
	task :seed => :environment do
		Geoname.retrieve_to_db
	end
end
