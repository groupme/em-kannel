require "spec_helper"

describe EventMachine::Kannel::Message do
  let(:message) {
    EM::Kannel::Message.new.tap do |message|
      message.body = "hi there"
      message.from = "+12125551212"
      message.to   = ["+17185551212"]
    end
  }

  describe "validations" do
    context "with valid attributes" do
      it "is valid" do
        message.should be_valid
      end
    end

    it "validates presence of body" do
      message.body = nil
      message.should_not be_valid
      message.errors[:body].should include("can't be blank")
    end

    it "validates body length is at most 160 characters" do
      message.body = "x" * 161
      message.should_not be_valid
      message.errors[:body].should include("is too long (maximum is 160 characters)")
    end

    it "validates presence of from" do
      message.from = nil
      message.should_not be_valid
      message.errors[:from].should include("can't be blank")
    end

    it "validates presence of to" do
      message.to = nil
      message.should_not be_valid
      message.errors[:to].should include("can't be blank")
    end
  end

  describe "#as_query" do
    it "returns a hash for use in the HTTP request" do
      message.as_query.should == {
        from: "+12125551212",
        to:   ["+17185551212"],
        text: "hi there"
      }
    end
  end
end
