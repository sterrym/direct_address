class Address < ActiveRecord::Base
	
	belongs_to :addressable, :polymorphic => true
	belongs_to :country
	belongs_to :region
	
	
	def single_line
		multiline.join(', ')
	end
	
	def multiline
		[street1, street2, [city, region_name, postal].compact.join(' '), country_abbrev].compact.collect{|s| s.length > 0 && s}
	end
	
	def region_name
		self.region && self.region.name || nil
	end
	
	def country_abbrev
		self.country && self.country.abbrev || nil
	end
	
end