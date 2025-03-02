# frozen_string_literal: true

module FileProcessor
  module Loggers
    class Error < Base
      def initialize(msg, processor_name)
        super('error', msg, processor_name)
      end
    end
  end
end
