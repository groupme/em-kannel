require "em-kannel"
require 'webmock/rspec'

RSpec.configure do |config|
  config.before(:each) do
    EM::Kannel.logger = Logger.new("/dev/null")
  end
end
