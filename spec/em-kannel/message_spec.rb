require "spec_helper"

describe EventMachine::Kannel::Message do
  let(:message) {
    EM::Kannel::Message.new.tap do |message|
      message.text        = "hi there"
      message.from_number = "+12125551212"
      message.to_numbers  = ["+17185551212"]
    end
  }

  describe "validations" do
    context "with valid attributes" do
      it "is valid" do
        message.should be_valid
      end
    end

    it "validates presence of text" do
      message.text = nil
      message.should_not be_valid
      message.errors[:text].should include("can't be blank")
    end

    it "validates text length is at most 160 characters" do
      message.text = "x" * 161
      message.should_not be_valid
      message.errors[:text].should include("is too long (maximum is 160 characters)")
    end

    it "validates presence of from_number" do
      message.from_number = nil
      message.should_not be_valid
      message.errors[:from_number].should include("can't be blank")
    end

    it "validates presence of to_numbers" do
      message.to_numbers = nil
      message.should_not be_valid
      message.errors[:to_numbers].should include("can't be blank")
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
