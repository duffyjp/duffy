# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'duffy/version'

Gem::Specification.new do |spec|
  spec.name          = "duffy"
  spec.version       = Duffy::VERSION
  spec.authors       = ["Jacob Duffy"]
  spec.email         = ["duffy.jp@gmail.com"]
  spec.summary       = "Library of things"
  spec.description   = "Random collection of useful things."
  spec.homepage      = "https://github.com/duffyjp/duffy"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'activesupport' # Required for ActiveSupport::Configurable
  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rails"
  spec.add_development_dependency "rspec"
end
