module EventMachine
  class Kannel
    def self.deliveries
      @deliveries ||= []
    end

    Client.class_eval do
      def deliver(block = nil)
        EM::Kannel.deliveries << @message
      end
    end
  end
end
