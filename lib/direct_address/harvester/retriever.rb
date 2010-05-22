require 'net/http'
require 'uri'
require 'yaml'
require 'rubygems'
require 'hpricot'
require 'fileutils'
require File.dirname(__FILE__) + '/extend_string.rb'

class Retriever
	URL = 'http://www.geonames.org'
	COUNTRIES_PATH = '/countries/'
	REGION_PATH = '/{ALPHA2}/administrative-division-{country}.html'
	
	def self.retrieve_all(path)
		countries = Retriever.retrieve_countries(path)
		countries.each do |country|
			regions = Retriever.retrieve_regions(country[0], country[1], path)
			puts "Successfully retrieved #{country[1]} :: found #{regions.size} regions"
		end
	end
	
	
	def self.retrieve_countries(filepath = nil)
		response = Retriever.get_body("#{Retriever::URL}#{Retriever::COUNTRIES_PATH}")
		return [] if response.nil?
		countries = Retriever.parse_countries response
		if filepath
			Retriever.export("#{filepath}/countries.yml", countries )
		end
		countries
	end
	
	def self.retrieve_regions(alpha2, country, filepath = nil)
		path = Retriever::REGION_PATH.gsub('{ALPHA2}', alpha2).gsub('{country}', Retriever.url_format(country))
		response = Retriever.get_body("#{Retriever::URL}#{path}")
		return [] if response.nil?
		regions = Retriever.parse_regions response
		if filepath
			Retriever.export("#{filepath}/regions/#{alpha2}.yml", regions)
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
		(doc/"span[@id^=\"nameSpan\"] a[@href]:first-child").collect {|elem| elem.innerHTML}
	end
	
	def self.url_format(string)
		string.downcase.gsub(' ', '-').removeaccents
	end
	
	def self.get_body(url)
		url = URI.parse(url) rescue nil
		return nil if url.nil?
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
end