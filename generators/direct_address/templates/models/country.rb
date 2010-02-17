class Country < ActiveRecord::Base
	
	has_many :regions
	
	validates_presence_of :abbreviation, :name
	
	alias_attribute :abbrev, :abbreviation

	default_scope :order => 'name ASC'
	
end