require 'spec_helper'
describe Duffy::System do

  # These methods return per-host settings, so all I can think of to test is that they return integers.
  # This generates the documentation more than anything.
  describe "cpus" do
    it "returns the number of physical cpus" do
      Duffy::System.cpus.should be_an(Integer)
    end
  end

  describe "cores" do
    it "returns the total number of CPU cores" do
      Duffy::System.cores.should be_an(Integer)
    end
  end

  describe "threads" do
    it "returns the total number of threads" do
      Duffy::System.threads.should be_an(Integer)
    end
  end
end
