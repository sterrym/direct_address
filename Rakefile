require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "direct_address"
    gem.summary = "Direct Address provides a rails app with simple address features. It allows up-to-date data to be pulled in from geoname.org."
    gem.description = "Direct Address provides a rails app with simple address features. This is a streamlined implementation of address functionality. Direct Address provides you with address, country, and region classes. It also provides a generator which generates the necessary javascript and rake tasks to implement properly. You'll also get form helpers to easily implement Direct Address in your views. A rake task is provided that allows up to date country and region information to be downloaded from geoname.org."
    gem.email = "mdnelson30@gmail.com"
    gem.homepage = "http://github.com/mnelson/direct_address"
    gem.authors = ["Mike Nelson"]
    gem.add_development_dependency "rspec", ">= 1.2.9"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :spec => :check_dependencies

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "direct_address #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
