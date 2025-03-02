# frozen_string_literal: true

module FileProcessor
  module Utils
    class ImageResizer
      def initialize(file, output_file = nil)
        @file = file
        @output_file = output_file || Utils::FileNameBuilder.new(file).call
      end

      def call
        resize_image
      end

      private

      attr_reader :file, :output_file

      def resize_image
        MiniMagick::Image.open(file)
                         .resize(ImageProcessorConfig::IMAGE_RESIZE_DIMENSIONS)
                         .write(output_file)
      rescue MiniMagick::Error => e
        Loggers::Error.new("MiniMagick failed: #{e.message}", source).call
      end

      def source
        self.class.name
      end
    end
  end
end
