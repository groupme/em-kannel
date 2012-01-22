module EventMachine
  class Kannel
    class Response
      attr_reader :duration

      def initialize(http, start=nil)
        @http     = http
        @duration = compute_duration(start)
      end

      def status
        @http.response_header.status.to_i
      end

      def success?
        status == 202
      end

      def body
        @http.response
      end

      def error
        @http.error
      end

      def guid
        body.split(": ").last
      end

      private

      def compute_duration(start)
        start && ((Time.now.to_f - start.to_f) * 1000.0).round
      end
    end
  end
end
