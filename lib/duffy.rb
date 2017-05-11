# External Requirements
require 'active_support'
require 'active_support/core_ext/object/blank'
require 'date'
require 'digest'

# Rails Only Requirements
if defined?(Rails)
  require File.dirname(__FILE__) + "/duffy/engine"
  require File.dirname(__FILE__) + "/duffy/railtie"
  require File.dirname(__FILE__) + "/duffy/active_record" if defined?(ActiveRecord)
end

# Normal Requirements
require File.dirname(__FILE__) + "/duffy/date"
require File.dirname(__FILE__) + "/duffy/git"
require File.dirname(__FILE__) + "/duffy/string"
require File.dirname(__FILE__) + "/duffy/system"
require File.dirname(__FILE__) + "/duffy/version"


# Required to add assets to pipeline
# example:
# [application.css]
# *= require duffy/reset
module Duffy
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
    config_accessor(:upcase_custom)     # {%w(NBC CNN FOO)}
    config_accessor(:upcase_default)    {%w(HR II III IV Q&A USA)}

    # Pretty Committer
    config_accessor(:committers)        # {"jpd" => "Jacob", "ers|Eric" => "Eric"}

    # Fiscal Year Start: Default July 1st.
    config_accessor(:fiscal_month)      {7}
    config_accessor(:fiscal_day)        {1}
  end
end
