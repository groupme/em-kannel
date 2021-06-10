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
          "TO=#{Digest::MD5.hexdigest(@message.to.delete(" "))}",
          "RESPONSE=#{@response.body}",
          "TIME=#{@response.duration}"
        ]
        parts << "ERROR=#{@response.error}" unless @response.success?

        parts.join(" ")
      end
    end
  end
end

