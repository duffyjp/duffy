require 'spec_helper'

describe Duffy::Git do
  {
    :log => ['git log --pretty=format:"%ad%x09%an%x09%s" --date=short',
             "2026-10-23\tJacob\tUpdate configuration\n", "2026-10-23\tJacob\tUpdate configuration"],
    :count => ['git rev-list HEAD --count', "123\n", 123],
    :email => ['git config --get user.email', " jacob@example.com\n", "jacob@example.com"],
    :branch => ['git rev-parse --abbrev-ref HEAD', " main\n", "main"]
  }.each do |method, (command, output, expected)|
    describe method.to_s do
      it "runs the expected command and normalizes its output" do
        expect(described_class).to receive(:`).with(command).and_return(output)

        expect(described_class.public_send(method)).to eq expected
      end

      it "handles empty output" do
        allow(described_class).to receive(:`).with(command).and_return("")

        expect(described_class.public_send(method)).to eq(method == :count ? 0 : nil)
      end

      it "returns nil when git cannot be executed" do
        allow(described_class).to receive(:`).with(command).and_raise(Errno::ENOENT)

        expect(described_class.public_send(method)).to be_nil
      end
    end
  end
end
