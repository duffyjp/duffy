require 'spec_helper'
describe Duffy::System do

  # These methods return per-host settings.  Verify the return object type and value within reason.
  # This generates the documentation more than anything.

  describe "battery_percent" do
    it "returns the percentage of battery remaining" do
      expect([Float, nil]).to include Duffy::System.battery_percent.class
    end
  end

  describe "cpu_percent" do
    it "returns the current cpu load percentage" do
      expect(Duffy::System.cpu_percent).to be_a(Float)
    end
  end

  describe "cores" do
    it "returns the total number of CPU cores" do
      expect(Duffy::System.cores).to be_an(Integer)
      expect(Duffy::System.cores).to be >= 1
    end
  end

  describe "cpus" do
    it "returns the number of physical cpus" do
      expect(Duffy::System.cpus).to be_an(Integer)
      expect(Duffy::System.cpus).to be >= 1
    end
  end

  describe "freespace" do
    it "returns working directory freespace in megabytes" do
      expect(Duffy::System.freespace).to be_an(Integer)
      expect(Duffy::System.freespace).to be >= 1
    end
  end

  describe 'mem_available' do
    it "returns the amount of available memory in Megabytes" do
      expect(Duffy::System.mem_available).to be_an(Integer)
      expect(Duffy::System.mem_available).to be > 0
    end
  end

  describe 'mem_percent' do
    it "returns the amount of used memory as a percentage of total" do
      expect(Duffy::System.mem_percent).to be_a(Float)
      expect(Duffy::System.mem_percent).to be > 0
    end
  end

  describe 'mem_total' do
    it "returns the total amount of physical memory in Megabytes" do
      expect(Duffy::System.mem_total).to be_an(Integer)
      expect(Duffy::System.mem_total).to be > 0
    end
  end

  describe 'mem_used' do
    it "returns the amount of used memory in Megabytes" do
      expect(Duffy::System.mem_used).to be_an(Integer)
      expect(Duffy::System.mem_used).to be > 0
    end
  end

  describe "threads" do
    it "returns the total number of threads" do
      expect(Duffy::System.threads).to be_an(Integer)
      expect(Duffy::System.threads).to be >= 1
    end
  end

  describe "virtual?" do
    it "returns true if in a hypervisor, false otherwise." do
      expect(Duffy::System.virtual?).to be_in [true, false]
    end
  end

end
