require 'spec_helper'
describe Date do

  describe "fiscal_year (Assuming July 1st Start)" do

    it "2000-07-01 => 2001" do
      expect(Date.new(2000,7,1).fiscal_year).to eq(2001)
    end

    it "2000-06-30 => 2000" do
      expect(Date.new(2000,6,30).fiscal_year).to eq(2000)
    end

    it "2000-01-01 => 2000" do
      expect(Date.new(2000,1,1).fiscal_year).to eq(2000)
    end

    it "1999-12-31 => 2000" do
      expect(Date.new(1999,12,31).fiscal_year).to eq(2000)
    end

  end


end

