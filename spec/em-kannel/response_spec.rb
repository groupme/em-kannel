require "spec_helper"

describe EM::Kannel::Response do
  let(:header) { mock(:header, status: "202") }
  let(:http) { mock(:http_client, response_header: header, response: "OK") }

  before do
    now = Time.now
    Time.stub(:now).and_return(now)
  end

  describe "#status" do
    it "returns the status code" do
      started = Time.now - 10
      http = mock(:http_client, response_header: header)

      response = EM::Kannel::Response.new(http, started)
      response.status.should == 202
    end
  end

  describe "#success?" do
    context "the status code is 202" do
      it "returns true" do
        response = EM::Kannel::Response.new(http)
        response.should be_success
      end
    end

    context "other status codes" do
      let(:header) { mock(:header, status: "500") }

      it "returns false" do
        response = EM::Kannel::Response.new(http)
        response.should_not be_success
      end
    end
  end

  describe "#body" do
    it "returns the body of the response" do
      response = EM::Kannel::Response.new(http)
      response.body.should == "OK"
    end
  end
end
