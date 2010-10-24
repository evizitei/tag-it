require 'rubygems'
require 'bundler/setup'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "tag-it"
    gem.summary = %Q{interaction with RFID receiver through a serial port.}
    gem.description = %Q{Interacting with RFID receivers through serial ports is not much fun.  This makes it a little better.  tag-it provides a class that will monitor a serial port for you, and will dispatch events through ruby's standard "observer" functionality when a tag comes into range and leaves.}
    gem.email = "ethan.vizitei@gmail.com"
    gem.homepage = "http://github.com/evizitei/tag-it"
    gem.authors = ["evizitei"]
    gem.add_development_dependency "thoughtbot-shoulda", ">= 0"
    gem.add_development_dependency'test-unit'
    gem.add_development_dependency 'mocha'
    gem.add_development_dependency 'timecop'
    gem.add_dependency "ruby-serialport"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/test_*.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

task :test => :check_dependencies

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "tag-it #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
