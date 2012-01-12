require "sassy_twitter_bootstrap/version"

if defined?(::Rails) && ::Rails.version >= "3.1"
  require 'sassy_twitter_bootstrap/engine'
end

module SassyTwitterBootstrap
  STYLESHEETS = File.expand_path("../vendor/assets/stylesheets/bootstrap", __FILE__)
end
