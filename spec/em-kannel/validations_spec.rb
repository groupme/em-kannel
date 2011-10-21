require "spec_helper"

describe EM::Kannel::Validations do
  before do
    class Model
      include EM::Kannel::Validations
      attr_accessor :value
      validates :value, presence: true
    end
  end

  describe "#validate!" do
    context "invalid" do
      it "raises an ArgumentError" do
        expect {
          Model.new.validate!
        }.to raise_exception(ArgumentError, /Invalid Model/)
      end
    end

    context "valid" do
      it "returns true" do
        instance = Model.new
        instance.value = "value"
        instance.validate!.should be_true
      end
    end
  end

end
