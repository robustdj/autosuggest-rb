# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "autosuggest/version"

Gem::Specification.new do |s|
  s.name        = "autosuggest-rb"
  s.version     = Autosuggest::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Derrick Camerino"]
  s.email       = ["robustdj@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{This is a gem that wraps the AutoSuggest javascript plugin}
  s.description = %q{This is a gem that wraps the AutoSuggest javascript plugin}

  s.rubyforge_project = "autosuggest-rb"

  s.add_dependency('rails', '~>3.0')
  s.add_dependency('yajl-ruby')

  s.add_development_dependency('sqlite3-ruby', '1.3.3')
  s.add_development_dependency('shoulda', '2.11.3')
  s.add_development_dependency('ruby-debug19')
  s.add_development_dependency('mongoid', '2.0.2')
  s.add_development_dependency('mongo_mapper', '0.9.1')
  s.add_development_dependency('bson_ext', '1.3.1')

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
