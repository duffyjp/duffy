require File.dirname(__FILE__) + "/duffy/version"
require File.dirname(__FILE__) + "/duffy/git"
require File.dirname(__FILE__) + "/duffy/string"

# Helper LazyLoaded:
require File.dirname(__FILE__) + "/duffy/railtie" if defined?(Rails)