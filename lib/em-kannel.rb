require "active_model"
require "em-http-request"
require "logger"

require "em-kannel/validations"
require "em-kannel/configuration"
require "em-kannel/message"
require "em-kannel/log_message"
require "em-kannel/client"
require "em-kannel/response"

module EventMachine
  class Kannel
    attr_accessor :configuration

    def initialize(configuration_options={})
      self.configuration = Configuration.new(configuration_options)
    end

    def self.logger
      @logger ||= Logger.new(STDOUT)
    end

    def self.logger=(new_logger)
      @logger = new_logger
    end

    def send_sms(message_options, &block)
      configuration.validate!

      message = Message.new(message_options)
      message.validate!

      client = Client.new(message, configuration)
      client.deliver(&block)
    end
  end
end
