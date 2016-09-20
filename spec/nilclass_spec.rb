require 'spec_helper'
describe NilClass do

  describe "to_date" do
    it "returns nil" do
      expect(nil.to_date).to eq(nil)
    end
  end
end
