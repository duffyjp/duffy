require 'spec_helper'
describe Duffy::System do

  # These methods return per-host settings.  Verify the return object type and value within reason.
  # This generates the documentation more than anything.
  describe "cpus" do
    it "returns the number of physical cpus" do
      expect(Duffy::System.cpus).to be_an(Integer)
      expect(Duffy::System.cpus).to be >= 1
    end
  end

  describe "cores" do
    it "returns the total number of CPU cores" do
      expect(Duffy::System.cores).to be_an(Integer)
      expect(Duffy::System.cores).to be >= 1

    end
  end

  describe "threads" do
    it "returns the total number of threads" do
      expect(Duffy::System.threads).to be_an(Integer)
      expect(Duffy::System.threads).to be >= 1

    end
  end

  describe "cpu_percent" do
    it "returns the current cpu load percentage" do
      expect(Duffy::System.cpu_percent).to be_a(Float)
    end
  end

  describe 'mem_total' do
    it "returns the total amount of physical memory in Megabytes" do
      expect(Duffy::System.mem_total).to be_an(Integer)
      expect(Duffy::System.mem_total).to be > 0
    end
  end

  describe 'mem_available' do
    it "returns the amount of available memory in Megabytes" do
      expect(Duffy::System.mem_available).to be_an(Integer)
      expect(Duffy::System.mem_available).to be > 0
    end
  end

  describe 'mem_used' do
    it "returns the amount of used memory in Megabytes" do
      expect(Duffy::System.mem_used).to be_an(Integer)
      expect(Duffy::System.mem_used).to be > 0
    end
  end


end
