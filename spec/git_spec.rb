require 'spec_helper'
describe Duffy::Git do

  # These methods return per-host settings, so all I can think of to test is that they are there.
  # This generates the documentation more than anything.
  describe "log" do
    it "returns the git log" do
      expect(defined?(Duffy::Git.log)).to eq("method")
    end
  end

  describe "count" do
    it "returns the git count" do
      expect(defined?(Duffy::Git.count)).to eq("method")
    end
  end

  describe "email" do
    it "returns the git user.email" do
      expect(defined?(Duffy::Git.email)).to eq("method")
    end
  end
end
