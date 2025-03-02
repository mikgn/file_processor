# frozen_string_literal: true

require_relative '../lib/file_processor'

RSpec.configure do |config|
  config.color = true
  config.formatter = :documentation
  config.filter_run_when_matching :focus
  config.order = :random
  Kernel.srand config.seed
end
