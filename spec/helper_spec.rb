require 'spec_helper'
require 'action_view'

describe BeastModeHelper do
  let(:helper) { Object.new.extend(described_class) }
  let(:collection) { [double("first record"), double("second record")] }

  context "with Parallel available" do
    let(:parallel) { double("Parallel") }

    before do
      stub_const("Parallel", parallel)
    end

    it "warms each partial before rendering the collection" do
      options = {:partial => "jobs/job", :collection => collection}
      expect(parallel).to receive(:each).with(collection, :in_processes => nil).
        ordered.and_yield(collection.first).and_yield(collection.last)
      expect(helper).to receive(:render).with(:partial => "jobs/job", :object => collection.first).ordered
      expect(helper).to receive(:render).with(:partial => "jobs/job", :object => collection.last).ordered
      expect(helper).to receive(:render).with(options).ordered.and_return("rendered collection")

      expect(helper.beast_mode(options)).to eq "rendered collection"
    end

    it "warms each object before rendering an inferred collection" do
      expect(parallel).to receive(:each).with(collection, :in_processes => nil).
        ordered.and_yield(collection.first).and_yield(collection.last)
      expect(helper).to receive(:render).with(collection.first).ordered
      expect(helper).to receive(:render).with(collection.last).ordered
      expect(helper).to receive(:render).with(collection).ordered.and_return("rendered collection")

      expect(helper.beast_mode(collection)).to eq "rendered collection"
    end

    it "rejects a missing partial" do
      expect { helper.beast_mode(:collection => collection) }.
        to raise_error(ArgumentError, "partial: option is required")
    end

    it "rejects a missing collection" do
      expect { helper.beast_mode(:partial => "jobs/job") }.
        to raise_error(ArgumentError, "collection: option is required")
    end

    it "rejects a collection that cannot be iterated" do
      expect { helper.beast_mode(:partial => "jobs/job", :collection => nil) }.
        to raise_error(ArgumentError, "collection doesn't look like something I can render")
    end

    it "renders an empty collection" do
      options = {:partial => "jobs/job", :collection => []}
      expect(parallel).to receive(:each).with([], :in_processes => nil)
      expect(helper).to receive(:render).with(options).and_return("")

      expect(helper.beast_mode(options)).to eq ""
    end
  end

  context "without Parallel" do
    before do
      hide_const("Parallel")
    end

    it "warns and falls back to rendering the collection normally" do
      expect(helper).to receive(:render).with(collection).and_return("rendered collection")

      expect { expect(helper.beast_mode(collection)).to eq "rendered collection" }.
        to output(/beast_mode is not executing in parallel/).to_stderr
    end
  end
end

describe DuffyHelper do
  let(:helper) do
    Object.new.extend(ActionView::Helpers::TagHelper).
      extend(ActionView::Helpers::UrlHelper).extend(described_class)
  end

  it "renders a linked menu item with HTML options" do
    expect do
      expect(helper.menu_tag("Help", "/help", :class => "menu-item")).
        to eq '<li class="menu-item"><a href="/help">Help</a></li>'
    end.to output(/DEPRECATION WARNING: This method will be removed without replacement/).to_stderr
  end

  it "escapes the menu title" do
    expect do
      expect(helper.menu_tag("<Help>", "/help")).
        to eq '<li><a href="/help">&lt;Help&gt;</a></li>'
    end.to output(/DEPRECATION WARNING/).to_stderr
  end
end

describe Duffy::Railtie do
  ["duffy_helper", "beast_mode_helper"].zip([DuffyHelper, BeastModeHelper]).each do |name, helper_module|
    it "registers #{helper_module} with Action View" do
      initializer = described_class.initializers.find { |entry| entry.name == name }
      initializer.run(Rails.application)

      expect(ActionView::Base.ancestors).to include(helper_module)
    end
  end
end