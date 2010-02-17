
module ActionView
	module Helpers
		module CountryAndRegionHelper
			
			def self.included(base)
				base.class_eval do
					include ActionView::Helpers::CountryAndRegionHelper::InstanceMethods
				end
			end
			
			module InstanceMethods
				def country_select_tag(object_string, country_id = nil, region_id = nil)
					object_string = object_string.to_s
					@countries ||= Country.all
					@regions = !country_id.nil? && Region.by_country(country_id) || [] 
					country_options = options_for_select([['Select a Country', nil]] + @countries.collect{|country| [country.name, country.id]}, country_id)
					region_options = options_for_select([['Select a Region', nil]] + @regions.collect{|region| [region.name, region.id]}, region_id)
					html = select_tag("#{object_string}[country_id]", country_options, :id => "#{object_string}_country_id")
					html << select_tag("#{object_string}[region_id]", region_options, :id => "#{object_string}_region_id")
					html << "<script type=\"text/javascript\">new CountrySelect({country_select_id : '#{object_string}_country_id', region_select_id : '#{object_string}_region_id'});</script>"
					html
				end
			end
			
		end
	end
end
::ActionView::Base.send :include, ActionView::Helpers::CountryAndRegionHelper