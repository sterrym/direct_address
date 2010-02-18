class Country < ActiveRecord::Base
	
	has_many :regions
	
	validates_presence_of :abbreviation, :name
	validates_length_of :abbreviation, :is => 2
	alias_attribute :abbrev, :abbreviation

	default_scope :order => 'name ASC'
	
	before_create :format_abbreviation
	
private

	def format_abbreviation
		self.abbreviation = self.abbreviation.upcase
	end
end