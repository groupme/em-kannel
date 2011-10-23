$:.push File.expand_path("../lib", __FILE__)

require "em-kannel/version"

Gem::Specification.new do |s|
  s.name        = "em-kannel"
  s.version     = EventMachine::Kannel::VERSION
  s.authors     = ["John Pignata"]
  s.email       = ["john@groupme.com"]
  s.homepage    = ""
  s.summary     = %q{EventMachine-driven SMS delivery via Kannel}

  s.rubyforge_project = "em-kannel"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "eventmachine", ">= 1.0.0.beta.3"
  s.add_dependency "em-http-request", ">= 1.0.0.beta.4"
  s.add_dependency "activemodel", "~> 3.1"

  s.add_development_dependency "rspec", "~> 2.7.0"
  s.add_development_dependency "webmock", "~> 1.7.7"
end
