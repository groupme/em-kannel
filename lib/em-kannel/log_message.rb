module EventMachine
  class Kannel
    class LogMessage
      def initialize(message, response)
        @message, @response = message, response
      end

      def log
        EM::Kannel.logger.info(message)
      end

      private

      def message
        parts = [
          "CODE=#{@response.status}",
          "FROM=#{@message.from}",
          "TO=#{@message.to}",
          "BODY=#{@message.body[0..100]}",
          "RESPONSE=#{@response.body}",
          "TIME=#{@response.duration}"
        ]
        parts << "ERROR=#{@response.error}" unless @response.success?

        parts.join(" ")
      end
    end
  end
end

