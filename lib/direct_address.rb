[:form_builder, :form_helper, :acts_as_addressable].each do |file|
	require File.join(File.dirname(__FILE__), 'direct_address', file.to_s)
end

require File.join(File.dirname(__FILE__), 'direct_address', 'harvester', 'geoname.rb')