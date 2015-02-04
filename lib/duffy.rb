require File.dirname(__FILE__) + "/duffy/version"
require File.dirname(__FILE__) + "/duffy/git"
require File.dirname(__FILE__) + "/duffy/string"

# Helper LazyLoaded:
require File.dirname(__FILE__) + "/duffy/railtie" if defined?(Rails)


# Required to add assets to pipeline
# example:
# [application.css]
# *= require duffy/reset
module Duffy
  class Engine < Rails::Engine
  end
end