require "spec_helper"

describe EM::Kannel::Response do
  let(:header) { mock(:header, status: "202") }
  let(:body) { "0: Accepted for delivery: 26ecfeea-6015-4025-bcae-0d0b71467d83" }
  let(:http) { mock(:http_client, response_header: header, response: body) }

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
      response.body.should == body
    end
  end

  describe "#guid" do
    it "returns the guid of the response" do
      response = EM::Kannel::Response.new(http)
      response.guid.should == "26ecfeea-6015-4025-bcae-0d0b71467d83"
    end
  end
end
