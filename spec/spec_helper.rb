$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'rubygems'
require 'spec'
require 'spec/autorun'
require 'active_record'
require 'action_view'
require 'direct_address'

%w(address country region).each do |model|
	require File.dirname(__FILE__) + "/../generators/direct_address/templates/models/#{model}.rb"
end

require 'model/user'

ActiveRecord::Base.logger = Logger.new(File.dirname(__FILE__) + '/debug.log')
ActiveRecord::Base.configurations = YAML::load(IO.read(File.dirname(__FILE__) + '/database.yml'))
ActiveRecord::Base.establish_connection(ENV['DB'] || 'mysql')
 
load(File.dirname(__FILE__) + '/schema.rb')

Spec::Runner.configure do |config|
  
end
