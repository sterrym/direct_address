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
          country_select_country_field(options) + 
          country_select_region_field(options) + 
          ( options[:skip_javascript] ? '' : country_select_javascript(options) )
        end
        
        def country_select_country_field(options = {})
          @countries ||= Country.all
          html = ''
          html << self.label(:country) if options[:include_labels]
          html << self.select(:country_id, ([['Select a Country', nil]] + @countries.collect{|country| [country.name, country.id]}))
          html = options[:nested_in] ? self.template.content_tag(options[:nested_in], options[:nested_in_options]) { html } : html
          html.respond_to?(:html_safe) ? html.html_safe : html
        end

        def country_select_region_field(options = {})
          html = ''
          html << self.label(:region) if options[:include_labels]
          html << self.select(:region_id, ([['Select a Region', nil]] + (self.object && self.object.country && self.object.country.regions.collect{|region| [region.name, region.id]} || [])))
          html = options[:nested_in] ? self.template.content_tag(options[:nested_in], options[:nested_in_options]) { html } : html
          html.respond_to?(:html_safe) ? html.html_safe : html
        end
        
        def country_select_javascript(options = {})
          sanitized_object_id = self.object_name.split('[').collect{|s| (s = s.gsub(']','')) && s.size > 0 && s || nil}.compact.join('_')
          if options[:use_jquery]
            js = "<script type=\"text/javascript\">jQuery(function($) {$('##{sanitized_object_id}_country_id').country_select({region_select_id : '##{sanitized_object_id}_region_id'});});</script>"
          else
            js = "<script type=\"text/javascript\">if(typeof(Prototype) != 'undefined'){Element.observe(window, 'load', function(){if(typeof(CountrySelect) == 'undefined'){try{console.log('country_select.js not loaded.');} catch (e) {};return;};new CountrySelect({country_select_id : '#{sanitized_object_id}_country_id', region_select_id : '#{sanitized_object_id}_region_id'})});}else{document.getElementById('#{sanitized_object_id}_country_id').style.display = 'none';document.getElementById('#{sanitized_object_id}_region_id').style.display = 'none';}</script>"
          end
          html = options[:nested_in] ? self.template.content_tag(options[:nested_in], { :style => "display:none" }) { js } : js
          html.respond_to?(:html_safe) ? html.html_safe : html
        end
      end
    end
  end
end

::ActionView::Helpers::FormBuilder.send :include, ActionView::Helpers::CountryAndRegion