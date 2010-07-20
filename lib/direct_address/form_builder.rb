module ActionView
	module Helpers
		module CountryAndRegion
			
			def self.included(base)
				base.class_eval do
					include ActionView::Helpers::CountryAndRegion::InstanceMethods
				end
			end
		
			module InstanceMethods
				def country_select(options = {})
					@countries ||= Country.all
					sanitized_object_id = self.object_name.split('[').collect{|s| (s = s.gsub(']','')) && s.size > 0 && s || nil}.compact.join('_')
					html = ''
					html << self.label(:country) if options[:include_labels]
					html << self.select(:country_id, ([['Select a Country', nil]] + @countries.collect{|country| [country.name, country.id]}))
					html << self.label(:region) if options[:include_labels]
					html << self.select(:region_id, ([['Select a Region', nil]] + (self.object && self.object.country && self.object.country.regions.collect{|region| [region.name, region.id]} || [])))
					if options[:use_jquery]
					  html << "<script type=\"text/javascript\">jQuery(function($) {$('##{sanitized_object_id}_country_id').country_select({region_select_id : '##{sanitized_object_id}_region_id'});});</script>"
				  else
					  html << "<script type=\"text/javascript\">if(typeof(Prototype) != 'undefined'){Element.observe(window, 'load', function(){if(typeof(CountrySelect) == 'undefined'){try{console.log('country_select.js not loaded.');} catch (e) {};return;};new CountrySelect({country_select_id : '#{sanitized_object_id}_country_id', region_select_id : '#{sanitized_object_id}_region_id'})});}else{document.getElementById('#{sanitized_object_id}_country_id').style.display = 'none';document.getElementById('#{sanitized_object_id}_region_id').style.display = 'none';}</script>"
				  end
					html
				end
			end
		end
	end
end

::ActionView::Helpers::FormBuilder.send :include, ActionView::Helpers::CountryAndRegion