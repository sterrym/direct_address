require 'rubygems'

class Geoname
	
	class InvalidModelError < StandardError; end
	
	def self.retrieve_to_db
		raise(InvalidModelError, 'Country and Region models must be generated before populating the database. Please make sure the gem is installed into a rails project then try running: script/generate direct_address') if !gem_integrated?
		countries = YAML.load_file(File.join(File.dirname(__FILE__), 'countries.yml'))
		for country in countries
			abbrev = country[0]
			name = country[1]
			c = Country.find_or_create_by_abbreviation(:abbreviation => abbrev, :name => name)
			regions = YAML.load_file(File.join(File.dirname(__FILE__), 'regions', "#{abbrev}.yml")) || []
			for region in regions
				r = c.regions.find_or_create_by_name(:name => region)
				puts "Created country / region: #{name} / #{region}"
			end
		end
	end
	
	
	private
	
	def self.gem_integrated?
		begin
			c = Country.new(:name => 'test', :abbreviation => 't')
			r = Region.new(:name => 'test', :country_id => -1)
			true
		rescue
			false
		end
	end
	
end