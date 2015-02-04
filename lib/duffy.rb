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

  def self.configuration
    @configuration ||= Duffy::Configuration.new
  end

  def self.configure
    yield configuration
  end

  # Override any duffy defaults conveniently with config options
  # example:
  # [config/initializers/duffy.rb]
  # Duffy.configure do |config|
  #   config.upcase_custom = %w(AOB CHS CME CT DFM HRS PA UDDS UWMF WREN)
  # end
  #
  class Configuration
    include ActiveSupport::Configurable

    # Smart Titlecase
    # Use :update_custom to add uppercase special cases
    # Use :update_default to replace my defaults
    config_accessor(:upcase_custom)
    config_accessor(:upcase_default)    {%w(HR II III IV Q&A USA)}
  end


end



