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
          from:     "+12125551212",
          to:       "+17185551212",
          text:     "testing"
        }
      )

      EM.run_block {
        EM::Kannel::Client.new(message, configuration).deliver
      }

      stub.should have_been_requested
    end

    context "delivery succeeds" do
      it "logs the delivery" do
        uuid = "24b8d670-0ad6-012f-13e0-60c5470504ea"

        stub = stub_request(:get, "http://www.example.com/api").with(
          query: {
            username: "user",
            password: "pass",
            from:     "+12125551212",
            to:       "+17185551212",
            text:     "testing"
          }).
          to_return(:status => 202, :body => uuid)

        EM::Kannel.logger.should_receive(:info).with(
          /CODE=202 FROM=\+12125551212 TO=78c929715ef3d957ad835697ced0e295 RESPONSE=#{uuid} TIME=[0-9]/

        )

        EM.run_block {
          EM::Kannel::Client.new(message, configuration).deliver
        }
      end
    end

    context "delivery fails" do
      it "logs the failure" do
        stub = stub_request(:get, "http://www.example.com/api").with(
          query: {
            username: "user",
            password: "pass",
            from:     "+12125551212",
            to:       "+17185551212",
            text:     "testing"
          }).
          to_return(:status => 404, :body => "API not available")

        EM::Kannel.logger.should_receive(:info).with(
          /CODE=404 FROM=\+12125551212 TO=78c929715ef3d957ad835697ced0e295 RESPONSE=API not available TIME=[0-9]/
        )

        EM.run_block {
          EM::Kannel::Client.new(message, configuration).deliver
        }
      end
    end
  end
end
