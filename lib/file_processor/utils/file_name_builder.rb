# frozen_string_literal: true

module FileProcessor
  module Utils
    class FileNameBuilder
      def initialize(file, ext = nil)
        @file = file
        @ext = ext || File.extname(file).delete_prefix('.')
        @timestamp = Time.now.to_i
      end

      def call
        build_file_name
      end

      private

      attr_reader :file, :ext, :timestamp

      def build_file_name
        "#{ImageProcessorConfig::PREVIEW_DIR}#{File.basename(file, '.*')}_preview_#{timestamp}.#{ext}"
      end
    end
  end
end
