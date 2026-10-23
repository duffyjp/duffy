require 'spec_helper'

describe Duffy::Configuration do
  around do |example|
    original_configuration = Duffy.configuration
    Duffy.instance_variable_set(:@configuration, described_class.new)
    example.run
  ensure
    Duffy.instance_variable_set(:@configuration, original_configuration)
  end

  it "preserves the default settings" do
    expect(Duffy.configuration.upcase_custom).to be_nil
    expect(Duffy.configuration.upcase_default).to eq %w(HR II III IV Q&A USA)
    expect(Duffy.configuration.committers).to be_nil
    expect(Duffy.configuration.fiscal_month).to eq 7
    expect(Duffy.configuration.fiscal_day).to eq 1
  end

  it "keeps instance overrides separate from class defaults and other instances" do
    Duffy.configuration.fiscal_month = 9

    expect(Duffy.configuration.fiscal_month).to eq 9
    expect(described_class.fiscal_month).to eq 7
    expect(described_class.new.fiscal_month).to eq 7
  end

  it "inherits class defaults without changing the parent when reassigned" do
    subclass = Class.new(described_class)
    expect(subclass.fiscal_month).to eq 7

    subclass.fiscal_month = 10

    expect(subclass.new.fiscal_month).to eq 10
    expect(described_class.fiscal_month).to eq 7
  end

  it "allows nil to override an inherited default" do
    Duffy.configuration.upcase_default = nil

    expect(Duffy.configuration.upcase_default).to be_nil
    expect(described_class.upcase_default).to eq %w(HR II III IV Q&A USA)
  end

  it "uses app-specific uppercase exceptions alongside the defaults" do
    Duffy.configure do |config|
      config.upcase_custom = %w(NBC DFM)
    end

    expect("nbc and dfm in the usa".smart_titlecase).to eq "NBC and DFM in the USA"
  end

  it "allows apps to replace the uppercase defaults" do
    Duffy.configure do |config|
      config.upcase_default = %w(CNN)
    end

    expect("cnn and usa".smart_titlecase).to eq "CNN and Usa"
  end

  it "uses app-specific committer mappings and preserves unmatched names" do
    Duffy.configure do |config|
      config.committers = {"jpd" => "Jacob", /ers|Eric/ => "Eric"}
    end

    expect("jpd".pretty_committer).to eq "Jacob"
    expect("ers".pretty_committer).to eq "Eric"
    expect("Eric".pretty_committer).to eq "Eric"
    expect("unknown".pretty_committer).to eq "unknown"
  end

  it "uses app-specific fiscal year boundaries" do
    Duffy.configure do |config|
      config.fiscal_month = 9
      config.fiscal_day = 15
    end

    expect(Date.new(2026, 9, 14).fiscal_year).to eq 2026
    expect(Date.new(2026, 9, 15).fiscal_year).to eq 2027
  end
end