require 'bundler/setup'
require 'rails'
Bundler.setup
require 'duffy'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = [:should]
  end
end