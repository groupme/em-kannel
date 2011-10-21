module EventMachine
  class Kannel
    class Message
      include Validations

      attr_accessor :text, :from_number, :to_numbers

      validates :text, presence: true, length: { maximum: 160 }
      validates :from_number, presence: true
      validates :to_numbers, presence: true

      def initialize(attributes={})
        self.from_number = attributes[:from_number]
        self.to_numbers = attributes[:to_numbers]
        self.text = attributes[:text]
      end

      def as_query
        {
          from: from_number,
          to:   to_numbers,
          text: text
        }
      end
    end
  end
end
