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

        http.callback { callback(http, start, message, &block) }
        http.errback { callback(http, start, message, &block) }
      end

      private

      def options
        {
          ssl: {
            verify_peer: configuration.verify_ssl_peer
          }
        }
      end

      def query
        query = {}
        query.merge!(configuration.as_query)
        query.merge!(message.as_query)
      end

      def callback(http, start, message, &block)
        response = Response.new(http, start)

        LogMessage.new(message, response).log
        block.call(response) if block_given?
      end
    end
  end
end
