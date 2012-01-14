require "spec_helper"

describe EventMachine::Kannel::Configuration do
  let(:attributes) do
    {
      :username             => "user",
      :password             => "pass",
      :url                  => "http://www.example.com/url",
      :dlr_callback_url     => "http://www.example.com/dlr_callback_url",
      :dlr_mask             => 1,
      :smsc                 => "Provider"
    }
  end

  describe ".new" do
    it "sets the attributes passed in the argument hash" do
      configuration = EM::Kannel::Configuration.new(attributes)

      attributes.each do |attribute_name, attribute_value|
        configuration.send(attribute_name).should == attribute_value
      end
    end
  end

  describe "validations" do
    let(:configuration) do
      EM::Kannel::Configuration.new(
        :username => "user",
        :password => "pass"
      )
    end

    it "validates presence of username" do
      configuration.username = nil
      configuration.should_not be_valid
      configuration.errors[:username].should include("can't be blank")
    end

    it "validates presence of password" do
      configuration.password = nil
      configuration.should_not be_valid
      configuration.errors[:password].should include("can't be blank")
    end
  end

  describe "#as_query" do
    it "returns a hash for use in the HTTP request" do
      configuration = EM::Kannel::Configuration.new(attributes)
      configuration.as_query.should == {
        :username   => "user",
        :password   => "pass",
        :"dlr-mask" => 1,
        :"dlr-url"  => "http://www.example.com/dlr_callback_url",
        :smsc       => "Provider"
      }
    end
  end
end
