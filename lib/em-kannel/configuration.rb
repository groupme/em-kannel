module EventMachine
  class Kannel
    class Configuration
      include Validations

      attr_accessor :username,
                    :password,
                    :url,
                    :dlr_callback_url,
                    :dlr_mask,
                    :verify_ssl_peer,
                    :smsc,
                    :coding

      validates :username, presence: true
      validates :password, presence: true
      validates :url, presence: true

      def initialize(attributes={})
        attributes = attributes.with_indifferent_access

        self.username         = attributes[:username]
        self.password         = attributes[:password]
        self.url              = attributes[:url]
        self.dlr_callback_url = attributes[:dlr_callback_url]
        self.dlr_mask         = attributes[:dlr_mask]
        self.verify_ssl_peer  = attributes[:verify_ssl_peer]
        self.smsc             = attributes[:smsc]
        self.coding           = attributes[:coding]
      end

      def as_query
        query = { username: username, password: password }
        query[:"dlr-mask"] = dlr_mask if dlr_mask
        query[:"dlr-url"]  = dlr_callback_url if dlr_callback_url
        query[:smsc]       = smsc if smsc
        query[:coding]     = coding if coding
        query
      end
    end
  end
end
