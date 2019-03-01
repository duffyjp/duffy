require 'spec_helper'

describe Array do

  describe "to_box" do

    it "creates a safe box around a array" do
      expect([:foo, 'bar'].to_box).to eq "+-----+-----+\n| foo | bar |\n+-----+-----+"
    end

    it "creates a fancy box around a string" do
      expect([:foo, 'bar'].to_box(safe: false)).to eq "╔─────╦─────╗\n║ foo ║ bar ║\n╚─────╩─────╝"
    end

    it "returns nil for empty arrays" do
      expect([].to_box).to eq nil
    end

    it "very long output is truncated" do
      expect(('a'..'z').to_a.to_box.split("\n").first.length).to eq 80
    end

  end
end