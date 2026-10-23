# External Requirements
require 'active_support'
require 'active_support/core_ext/class/attribute'
require 'active_support/core_ext/object/blank'
require 'date'
require 'digest'
require 'shellwords'

# Rails Only Requirements
if defined?(Rails)
  require File.dirname(__FILE__) + "/duffy/engine"
  require File.dirname(__FILE__) + "/duffy/railtie"
  require File.dirname(__FILE__) + "/duffy/active_record" if defined?(ActiveRecord)
end

# Normal Requirements
require File.dirname(__FILE__) + "/duffy/array"
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
    # Smart Titlecase
    class_attribute :upcase_custom, :upcase_default, :instance_predicate => false
    self.upcase_default = %w(HR II III IV Q&A USA)

    # Pretty Committer
    class_attribute :committers, :instance_predicate => false

    # Fiscal Year Start: Default July 1st.
    class_attribute :fiscal_month, :fiscal_day, :instance_predicate => false
    self.fiscal_month = 7
    self.fiscal_day = 1
  end
end
