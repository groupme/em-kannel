module EventMachine
  class Kannel
    class Client
      attr_accessor :message, :configuration

      def initialize(message, configuration)
        self.message       = message
        self.configuration = configuration
      end

      def deliver(&block)
        start = Time.now.to_f
        http  = EM::HttpRequest.new(configuration.url, options).get(query: query)

        http.callback do
          response = Response.new(http, start)
          block.call(response) if block_given?
        end

        http.errback do |e|
          response = Response.new(http, start)
          block.call(response) if block_given?
        end
      end

      private

      def options
        options = {}
        options[:ssl] = {verify_peer: configuration.verify_ssl_peer}
        options
      end

      def query
        query = {}
        query.merge!(configuration.as_query)
        query.merge!(message.as_query)
      end
    end
  end
end
