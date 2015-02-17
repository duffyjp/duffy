require 'spec_helper'
describe String do


  describe "to_ssn" do
    it "maintains an already formatted SSN" do
      "123-45-6789".to_ssn.should == "123-45-6789"
    end

    it "formats a ssn with leading zero properly" do
      "078051120".to_ssn.should == "078-05-1120"
    end

    it "formats an unformatted SSN" do
      "123456789".to_ssn.should == "123-45-6789"
    end

    it "adds leading zeros to 8 digit SSNs (yes, they exist)" do
      "12345678".to_ssn.should == "012-34-5678"
    end

    it "should correctly add leading zeroes to short SSNs that start with 0" do
      "01".to_ssn.should == "000-00-0001"
      "1".to_ssn.should == "000-00-0001"
    end
  end

  describe "sanitize_ssn" do

    it "123456789   => 123456789" do
      "123456789".sanitize_ssn.should == "123456789"
      # Good
    end

    it "123-45-6789 => 123456789" do
      "123-45-6789".sanitize_ssn.should == "123456789"
      # Good
    end

    it "000-12-3456 => nil" do
      "000-12-3456".sanitize_ssn.should == nil
      # Invalid Area
    end

    it "078051120   => 078051120 " do
      "078051120".sanitize_ssn.should == "078051120"
    end

    it "666123456   => nil" do
      "666123456".sanitize_ssn.should == nil
      # Invalid Area
    end

    it "derp        => nil" do
      "derp".sanitize_ssn.should == nil
      # Bogus
    end

    it "123456      => nil" do
      "123456".sanitize_ssn.should == nil
      # Too short ( becomes 000123456: Invalid Area )
    end

    it "999999999   => nil" do
      "999999999".sanitize_ssn.should == nil
      # Important.  Many HRS entries
    end

    it "-           => nil" do
      "-".sanitize_ssn.should == nil
      # Important.  Many HRS entries
    end
  end








end