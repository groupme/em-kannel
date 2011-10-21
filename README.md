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
      message.text.should == ...
