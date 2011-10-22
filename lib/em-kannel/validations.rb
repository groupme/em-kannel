module EventMachine
  class Kannel
    module Validations
      def self.included(base)
        base.class_eval do
          include ActiveModel::Validations
        end
      end

      def validate!
        if invalid?
          message = "Invalid #{friendly_name}: #{full_messages}"
          raise ArgumentError.new(message)
        end

        true
      end

      def friendly_name
        self.class.model_name.human
      end

      private

      def full_messages
        errors.full_messages.to_sentence
      end
    end
  end
end
