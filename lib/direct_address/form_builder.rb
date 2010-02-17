module ActionView
	module Helpers
		module CountryAndRegion
			
			def self.included(base)
				base.class_eval do
					include ActionView::Helpers::CountryAndRegion::InstanceMethods
				end
			end
		
			module InstanceMethods
				def country_select
					@countries ||= Country.all
					select_name = self.object_name
					html = self.select(:country_id, ([['Select a Country', nil]] + @countries.collect{|country| [country.name, country.id]}))
					html << self.select(:region_id, ([['Select a Region', nil]] + (self.object && self.object.country && self.object.country.regions.collect{|region| [region.name, region.id]} || [])))
					html << "<script type=\"text/javascript\">Element.observe(window, 'load', function(){new CountrySelect({country_select_id : '#{select_name}_country_id', region_select_id : '#{select_name}_region_id'})});</script>"
					html
				end
			end
		end
	end
end

::ActionView::Helpers::FormBuilder.send :include, ActionView::Helpers::CountryAndRegion