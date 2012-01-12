# -*- encoding: utf-8 -*-
require File.expand_path('../lib/sassy_twitter_bootstrap/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Varley"]
  gem.email         = ["vht3@yahoo.com"]
  gem.description   = %q{SCSS version of twitter bootstrap for experimenting with Bootstrap v2}
  gem.summary       = %q{Sassy Twitter Bootstrap}
  
  gem.homepage      = "https://github.com/varley/sassy-twitter-bootstrap"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "sassy-twitter-bootstrap"
  gem.require_paths = ["lib"]
  gem.version       = SassyTwitterBootstrap::VERSION

  gem.add_runtime_dependency "sass"
end
