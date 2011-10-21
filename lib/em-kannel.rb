require "active_model"
require "em-http-request"

require "em-kannel/validations"
require "em-kannel/configuration"
require "em-kannel/message"
require "em-kannel/client"
require "em-kannel/response"
require "em-kannel/version"

module EventMachine
  class Kannel
    attr_accessor :configuration

    def initialize(configuration_options={})
      self.configuration = Configuration.new(configuration_options)
    end

    def send_sms(message_options, &block)
      configuration.validate!

      message = Message.new(message_options)
      message.validate!

      Client.new(message, configuration).deliver(&block)
    end
  end
end
