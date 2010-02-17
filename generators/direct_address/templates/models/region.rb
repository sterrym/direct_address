class Region < ActiveRecord::Base
	
	belongs_to :country
	validates_presence_of :name, :country
	
	default_scope :order => 'name ASC'
	
	named_scope :by_country, lambda {|country| country && (country.is_a?(Country) && (country = country.id) || true) && {:conditions => ['country_id = ?', country]} || {}}
end