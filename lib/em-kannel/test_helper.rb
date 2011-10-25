require "ostruct"

module EventMachine
  class Kannel
    def self.deliveries
      @deliveries ||= []
    end

    Client.class_eval do
      def fake_response
        status = OpenStruct.new(status: 202)
        http   = OpenStruct.new(response_header: status)

        Response.new(http, Time.now)
      end

      def deliver(&block)
        EM::Kannel.deliveries << @message
        yield(fake_response) if block_given?
      end
    end
  end
end
