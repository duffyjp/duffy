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

  describe "to_markdown" do

    it "creates a markdown compatible table" do
      array = [[1,2,3],[4,5,6],[7,8,9]]
      expect(array.to_markdown).to eq "Integer | Integer | Integer\n--------|---------|---------\n1       | 2       | 3      \n4       | 5       | 6      \n7       | 8       | 9      \n"
    end

    it "uses the first row for column header names" do
      array = [[1, "a", Date.today]]
      expect(array.to_markdown.lines.first).to eq "Integer | String | Date      \n"
    end

    it "arrays with very short data format correctly" do
      array = [[1,2,3],[4,5,6],[7,8,9]]
      expect(array.to_markdown).to eq "Integer | Integer | Integer\n--------|---------|---------\n1       | 2       | 3      \n4       | 5       | 6      \n7       | 8       | 9      \n"
    end

    it "rejects non-2D arrays" do
      array = ["Wisconsin", "cheese"]
      expect{array.to_markdown}.to output("Unable to generate table: expected 2D array\n").to_stderr
    end

    it "rejects arrays with inconsistent dimensions" do
      array = [[1],[2,3],[4,5,6]]
      expect{array.to_markdown}.to output("Unable to generate table: element size differs (2 should be 1)\n").to_stderr
    end
  end

end