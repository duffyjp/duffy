require 'spec_helper'
describe Date do

  describe "fiscal_year (Assuming July 1st Start)" do

    it "2000-07-01 => 2001" do
      expect(Date.new(2000, 7, 1).fiscal_year).to eq(2001)
    end

    it "2000-06-30 => 2000" do
      expect(Date.new(2000, 6, 30).fiscal_year).to eq(2000)
    end

    it "2000-01-01 => 2000" do
      expect(Date.new(2000, 1, 1).fiscal_year).to eq(2000)
    end

    it "1999-12-31 => 2000" do
      expect(Date.new(1999, 12, 31).fiscal_year).to eq(2000)
    end

  end

  describe "beginning_of_fiscal_year (Assuming July 1st Start)" do

    # First day stays the same
    it "2000-07-01 => 2000-07-01" do
      expect(Date.new(2000, 7, 1).beginning_of_fiscal_year).to eq Date.new(2000, 7, 1)
    end

    # Previous day is the previous FY
    it "2000-06-30 => 1999-07-01" do
      expect(Date.new(2000, 6, 30).beginning_of_fiscal_year).to eq Date.new(1999, 7, 1)
    end

    # Date into the next calendar year but before the FY change.
    it "2001-01-01 => 2000-07-01" do
      expect(Date.new(2001, 1, 1).beginning_of_fiscal_year).to eq Date.new(2000, 7, 1)
    end

  end

  describe "end_of_fiscal_year (Assuming July 1st Start)" do

    # Last day stays the same
    it "2000-06-30 => 2000-06-30" do
      expect(Date.new(2000, 6, 30).end_of_fiscal_year).to eq Date.new(2000, 6, 30)
    end

    # Day after the last day is the next FY end
    it "2000-07-01 => 2001-06-30" do
      expect(Date.new(2000, 7, 1).end_of_fiscal_year).to eq Date.new(2001, 6, 30)
    end

  end

end
