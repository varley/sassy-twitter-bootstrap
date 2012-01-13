require "sassy_twitter_bootstrap/version"

if defined?(::Rails) && ::Rails.version >= "3.1"
  require 'sassy_twitter_bootstrap/engine'
end

module SassyTwitterBootstrap
end
