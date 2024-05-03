# frozen_string_literal: true

require 'byebug'

RSpec.configure do |config|
  config.default_formatter = 'documentation'
  config.mock_with :rspec
end
