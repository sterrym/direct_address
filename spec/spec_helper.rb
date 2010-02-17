$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'rubygems'
require 'spec'
require 'spec/autorun'
require 'active_record'
require 'direct_address'
require 'direct_address/address'
require 'direct_address/country'
require 'direct_address/region'
require 'model/user'

ActiveRecord::Base.logger = Logger.new(File.dirname(__FILE__) + '/debug.log')
ActiveRecord::Base.configurations = YAML::load(IO.read(File.dirname(__FILE__) + '/database.yml'))
ActiveRecord::Base.establish_connection(ENV['DB'] || 'mysql')
 
load(File.dirname(__FILE__) + '/schema.rb')

Spec::Runner.configure do |config|
  
end
