
module ActionView
  module Helpers
    module CountryAndRegionHelper

      def self.included(base)
        base.class_eval do
          include ActionView::Helpers::CountryAndRegionHelper::InstanceMethods
        end
      end

      module InstanceMethods
        def country_select_tag(object_string, country_id = nil, region_id = nil, options = {})
          object_string = object_string.to_s
          object_id = object_string.split('[').collect{|s| (s = s.gsub(']','')) && s.size > 0 && s || nil}.compact.join('_')
          @countries ||= Country.all
          @regions = !country_id.nil? && Region.by_country(country_id) || [] 
          country_options = options_for_select([['Select a Country', nil]] + @countries.collect{|country| [country.name, country.id]}, country_id)
          region_options = options_for_select([['Select a Region', nil]] + @regions.collect{|region| [region.name, region.id]}, region_id)
          html = ''
          html.concat label_tag("#{object_string}[country_id]", 'Country') if options[:include_labels]
          html.concat select_tag("#{object_string}[country_id]", country_options, :id => "#{object_id}_country_id")
          html.concat label_tag("#{object_string}[region_id]", 'Region') if options[:include_labels]
          html.concat select_tag("#{object_string}[region_id]", region_options, :id => "#{object_id}_region_id")
          if options[:use_jquery]
            html.concat "<script type=\"text/javascript\">jQuery(function($) {$('##{object_id}_country_id').country_select({region_select_id : '##{object_id}_region_id'});});</script>"
          else
            html.concat "<script type=\"text/javascript\">if(typeof(Prototype) != 'undefined'){Element.observe(window, 'load', function(){if(typeof(CountrySelect) == 'undefined'){try{console.log('country_select.js not loaded.');} catch (e) {};return;};new CountrySelect({country_select_id : '#{object_id}_country_id', region_select_id : '#{object_id}_region_id'});});}else{document.getElementById('#{object_id}_country_id').style.display = 'none';document.getElementById('#{object_id}_region_id').style.display = 'none';}</script>"
          end
          html.respond_to?(:html_safe) ? html.html_safe : html
        end
      end

    end
  end
end
::ActionView::Base.send :include, ActionView::Helpers::CountryAndRegionHelper