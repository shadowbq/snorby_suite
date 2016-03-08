# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "snorby_suite/version"

Gem::Specification.new do |s|
  s.name        = "snorby_suite"
  s.version     = SnorbySuite::VERSION
  s.authors     = ["shadowbq"]
  s.email       = ["shadowbq@gmail.com"]
  s.licenses    = ["MIT"]
  s.homepage    = ""
  s.summary     = %q{Snorby Development Test Suite}
  s.description = %q{Snorby development and testing suite for snort rails application.}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = ["alert_daemon", "snorby_suite", "u2_dump"]
  s.require_paths = ["lib"]

  s.add_runtime_dependency "pcaprub"
  s.add_runtime_dependency "packetfu", '~> 1.1.11'
  s.add_runtime_dependency "foreman", ["= 0.46.0"]

end
