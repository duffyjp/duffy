# http://stackoverflow.com/questions/5791211/how-do-i-extract-rails-view-helpers-into-a-gem

require File.dirname(__FILE__) + "/duffy_helper"
module Duffy
  class Railtie < Rails::Railtie
    initializer "duffy_helper" do
      ActiveSupport.on_load( :action_view ){ include DuffyHelper }
    end
  end
end