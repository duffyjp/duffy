require 'spec_helper'
describe Duffy::Git do

  # These methods return per-host settings, so all I can think of to test is that they are there.
  # This generates the documentation more than anything.
  describe "log" do
    it "returns the git log" do
      defined?(Duffy::Git.log).should == "method"
    end
  end

  describe "count" do
    it "returns the git count" do
      defined?(Duffy::Git.count).should == "method"
    end
  end

  describe "email" do
    it "returns the git user.email" do
      defined?(Duffy::Git.email).should == "method"
    end
  end
end
