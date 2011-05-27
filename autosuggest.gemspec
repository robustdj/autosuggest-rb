# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "autosuggest/version"

Gem::Specification.new do |s|
  s.name        = "autosuggest"
  s.version     = Autosuggest::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Derrick Camerino"]
  s.email       = ["robustdj@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{This is a gem that wraps the AutoSuggest javascript plugin}
  s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "autosuggest"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
