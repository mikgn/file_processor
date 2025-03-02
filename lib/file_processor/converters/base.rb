# frozen_string_literal: true

module FileProcessor
  module Converters
    class Base
      def initialize(input_file, output_file = nil, output_ext = nil)
        @input_file = input_file
        @output_file = output_file || Utils::FileNameBuilder.new(input_file, output_ext).call
      end

      def call
        raise NotImplementedError, "#{self.class.name} must implement `call`"
      end

      private

      attr_reader :input_file, :output_file

      def source
        self.class.name
      end
    end
  end
end
