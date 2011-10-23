module EventMachine
  class Kannel
    class Message
      include Validations

      attr_accessor :body, :from, :to

      validates :body, presence: true, length: { maximum: 160 }
      validates :from, presence: true
      validates :to, presence: true

      def initialize(attributes={})
        self.from = attributes[:from]
        self.to   = attributes[:to]
        self.body = attributes[:body]
      end

      def as_query
        { from: from,to: to, text: body }
      end
    end
  end
end
