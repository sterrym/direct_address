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
					sanitized_object_id = self.object_name.split('[').collect{|s| (s = s.gsub(']','')) && s.size > 0 && s || nil}.compact.join('_')
					html = self.select(:country_id, ([['Select a Country', nil]] + @countries.collect{|country| [country.name, country.id]}))
					html << self.select(:region_id, ([['Select a Region', nil]] + (self.object && self.object.country && self.object.country.regions.collect{|region| [region.name, region.id]} || [])))
					html << "<script type=\"text/javascript\">if(typeof(Prototype) != 'undefined'){Element.observe(window, 'load', function(){new CountrySelect({country_select_id : '#{sanitized_object_id}_country_id', region_select_id : '#{sanitized_object_id}_region_id'})});}else{document.getElementById('#{sanitized_object_id}_country_id').style.display = 'none';document.getElementById('#{sanitized_object_id}_region_id').style.display = 'none';}</script>"
					html
				end
			end
		end
	end
end

::ActionView::Helpers::FormBuilder.send :include, ActionView::Helpers::CountryAndRegion