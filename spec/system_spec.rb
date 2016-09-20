require 'spec_helper'
describe Duffy::System do

  # These methods return per-host settings, so all I can think of to test is that they return integers.
  # This generates the documentation more than anything.
  describe "cpus" do
    it "returns the number of physical cpus" do
      expect(Duffy::System.cpus).to be_an(Integer)
    end
  end

  describe "cores" do
    it "returns the total number of CPU cores" do
      expect(Duffy::System.cores).to be_an(Integer)
    end
  end

  describe "threads" do
    it "returns the total number of threads" do
      expect(Duffy::System.threads).to be_an(Integer)
    end
  end

  describe "cpu_percent" do
    it "returns the current cpu load percentage" do
      expect(Duffy::System.cpu_percent).to be_a(Float)
    end
  end





end
