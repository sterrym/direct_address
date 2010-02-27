require 'net/http'
require 'uri'
require 'yaml'
require 'rubygems'
require 'hpricot'
require File.dirname(__FILE__) + '/extend_string.rb'

class Geoname
	URL = 'http://www.geonames.org'
	COUNTRIES_PATH = '/countries/'
	REGION_PATH = '/{ALPHA2}/administrative-division-{country}.html'
	
	class InvalidModelError < StandardError; end
	
	def self.retrieve_to_db
		raise(InvalidModelError, 'Country and Region models must be generated before populating the database. Please make sure the gem is installed into a rails project then try running: script/generate direct_address') if !gem_integrated?
		countries = Geoname.retrieve_countries
		countries.each do |country|
			c = Country.find_by_abbreviation(country[0]) || Country.create(:abbreviation => country[0], :name => country[1])
			regions = Geoname.retrieve_regions(country[0], country[1])
			puts "Successfully retrieved #{country[1]} :: found #{regions.size} regions"
			for region in regions
				if c.regions.count(:conditions => ['lower(name) = ?', region]) == 0
					c.regions.create(:name => region)
				end
			end
		end
	end
	
	def self.retrieve_all(path)
		countries = Geoname.retrieve_countries(path)
		countries.each do |country|
			regions = Geoname.retrieve_regions(country[0], country[1], path)
			puts "Successfully retrieved #{country[1]} :: found #{regions.size} regions"
		end
	end
	
	
	def self.retrieve_countries(filepath = nil)
		response = Geoname.get_body("#{Geoname::URL}#{Geoname::COUNTRIES_PATH}")
		countries = Geoname.parse_countries response
		if filepath
			Geoname.export("#{filepath}/countries.yml", countries )
		end
		countries
	end
	
	def self.retrieve_regions(alpha2, country, filepath = nil)
		path = Geoname::REGION_PATH.gsub('{ALPHA2}', alpha2).gsub('{country}', Geoname.url_format(country))
		response = Geoname.get_body("#{Geoname::URL}#{path}")
		regions = Geoname.parse_regions response
		if filepath
			Geoname.export("#{filepath}/regions/#{alpha2}.yml", regions)
		end
		regions
	end
	
	private
	
	def self.parse_countries(body)
		doc = Hpricot(body)
		(doc/"#countries td > a[@href]").collect do |elem|
			href = elem.attributes['href']
			fips = nil
			if (href =~ /countries\/(.+)\//)
				fips = $1
			end
			[fips, elem.innerHTML]
		end
	end
	
	def self.parse_regions(body)
		doc = Hpricot(body)
		(doc/"#subdivtable tr td:nth-child(4) a[@href]").collect {|elem| elem.innerHTML}
	end
	
	def self.url_format(string)
		string.downcase.gsub(' ', '-').removeaccents
	end
	
	def self.get_body(url)
		url = URI.parse(url)
		request = Net::HTTP::Get.new(url.path)
		response = Net::HTTP.start(url.host, url.port) {|http| http.request(request)}
		response.body
	end
	
	def self.export(path, content)
		FileUtils.mkdir_p(File.dirname(path))
		File.open(path, 'w+' ) do |out|
			YAML.dump(content,out)
		end
	end
	
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