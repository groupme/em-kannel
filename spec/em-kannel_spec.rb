require "spec_helper"

describe EventMachine::Kannel do
  describe ".send_sms" do
    context "invalid configuration options" do
      it "raises an ArgumentError with the validation errors" do
        expect {
          kannel = EM::Kannel.new({})
          kannel.send_sms({})
        }.to raise_exception(ArgumentError, /Invalid EventMachine::Kannel::Configuration/)
      end
    end
  end
end
