# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{tag-it}
  s.version = "0.3.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["evizitei"]
  s.date = %q{2010-11-22}
  s.description = %q{Interacting with RFID receivers through serial ports is not much fun.  This makes it a little better.  tag-it provides a class that will monitor a serial port for you, and will dispatch events through ruby's standard "observer" functionality when a tag comes into range and leaves.}
  s.email = %q{ethan.vizitei@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".bundle/config",
     ".document",
     ".gitignore",
     "Gemfile",
     "Gemfile.lock",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "lib/tag_it.rb",
     "lib/tag_it/monitor.rb",
     "lib/tag_it/tag_snapshot.rb",
     "lib/tag_it/tag_tracker.rb",
     "pkg/tag-it-0.1.0.gem",
     "pkg/tag-it-0.2.1.gem",
     "pkg/tag-it-0.2.2.gem",
     "pkg/tag-it-0.3.1.gem",
     "tag-it.gemspec",
     "test/helper.rb",
     "test/mock_serial_port.rb",
     "test/test_tag_snapshot.rb",
     "test/test_tag_tracker.rb"
  ]
  s.homepage = %q{http://github.com/evizitei/tag-it}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{interaction with RFID receiver through a serial port.}
  s.test_files = [
    "test/helper.rb",
     "test/mock_serial_port.rb",
     "test/test_tag_snapshot.rb",
     "test/test_tag_tracker.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<thoughtbot-shoulda>, [">= 0"])
      s.add_development_dependency(%q<test-unit>, [">= 0"])
      s.add_development_dependency(%q<mocha>, [">= 0"])
      s.add_development_dependency(%q<timecop>, [">= 0"])
      s.add_runtime_dependency(%q<ruby-serialport>, [">= 0"])
    else
      s.add_dependency(%q<thoughtbot-shoulda>, [">= 0"])
      s.add_dependency(%q<test-unit>, [">= 0"])
      s.add_dependency(%q<mocha>, [">= 0"])
      s.add_dependency(%q<timecop>, [">= 0"])
      s.add_dependency(%q<ruby-serialport>, [">= 0"])
    end
  else
    s.add_dependency(%q<thoughtbot-shoulda>, [">= 0"])
    s.add_dependency(%q<test-unit>, [">= 0"])
    s.add_dependency(%q<mocha>, [">= 0"])
    s.add_dependency(%q<timecop>, [">= 0"])
    s.add_dependency(%q<ruby-serialport>, [">= 0"])
  end
end

