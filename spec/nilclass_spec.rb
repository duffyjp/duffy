require 'spec_helper'
describe NilClass do

  describe "to_date" do
    it "returns nil" do
      nil.to_date.should == nil
    end
  end
end
