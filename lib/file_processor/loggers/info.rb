# frozen_string_literal: true

module FileProcessor
  module Loggers
    class Info < Base
      def initialize(msg, processor_name)
        super('info', msg, processor_name)
      end
    end
  end
end
