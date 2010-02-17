module Direct
	module Address
		
		def self.included(base)
			base.extend ::Direct::Address::ClassMethods
		end
		
		module ClassMethods
			
			def acts_as_addressable
				belongs_to :address, :as => :addressable
				accepts_nested_attributes_for :address
				attr_accessible :address_attributes
			end
		end
		
	end
end

::ActiveRecord::Base.send(:include, ::Direct::Address)