require "spec_helper"

describe EventMachine::Kannel::Client do
  describe "#deliver" do
    let(:configuration) {
      EM::Kannel::Configuration.new(
        url: "http://www.example.com/api",
        username: "user",
        password: "pass"
      )
    }

    let(:message) do
      EM::Kannel::Message.new(
        from: "+12125551212",
        to:   "+17185551212",
        body: "testing"
      )
    end

    it "delivers the message to the specified URL" do
      stub = stub_request(:get, "http://www.example.com/api").with(
        query: {
          username: "user",
          password: "pass",
          from: "+12125551212",
          to: "+17185551212",
          body: "testing"
        }
      )

      EM.run_block {
        EM::Kannel::Client.new(message, configuration).deliver
      }

      stub.should have_been_requested
    end
  end
end
