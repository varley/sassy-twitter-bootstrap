# -*- encoding: utf-8 -*-
require File.expand_path('../lib/sassy_twitter_bootstrap/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Varley"]
  gem.description   = %q{SCSS version of Twitter Bootstrap primarily for experimenting with 2.0}
  gem.summary       = %q{Sassy Twitter Bootstrap}
  
  gem.homepage      = "https://github.com/varley/sassy-twitter-bootstrap"

  gem.name          = "sassy_twitter_bootstrap"
  gem.require_paths = ["lib"]
  gem.version       = SassyTwitterBootstrap::VERSION

  gem.files = Dir["vendor/**/*.scss"] + Dir["vendor/**/*.sass"] + Dir["vendor/**/*.js"] + ["README.md", "LICENSE"]

  #gem.add_dependency 'sass-rails', '~> 3.1'
  gem.add_runtime_dependency "sass"
end
