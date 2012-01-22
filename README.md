# Kannel SMS delivery for EventMachine

# Install

      gem "em-kannel", :git => "git://github.com/groupme/em-kannel.git"

# Usage

      require "em-kannel"

      kannel = EM::Kannel.new(
        username: "user",
        password: "password",
        url:      "http://www.example.com/sendsms"
      )


      EM.run do
        kannel.sendsms(
          from: "+12105551010",
          to: "+12125551212 +17185551212",
          body: "Hello World"
        )
        EM.stop
      end

## Callbacks

You can pass a block to process the response body:

      kannel.sendsms(message_options) do |response|
        if response.success?
          log("Hooray!")
        else
          log("Boo! #{response.body}")
        end
      end

# Testing

To test em-kannel's deliveries, start by simply requiring this file after EM::Kannel has already
been loaded:

      require "em-kannel"
      require "em-kannel/test_helper"

This will nullify actual deliveries and instead, push them onto an accessible
list:

      kannel = EM::Kannel.new(configuration_options)

      expect {
       kannel.send_sms(message_options)
      }.to change { EM::Kannel.deliveries.size }.by(1)

      message = EM::Kannel.deliveries.first
      message.should be_an_instance_of(EM::Kannel::Message)
      message.body.should == ...

# Legal

See LICENSE for details
