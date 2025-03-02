# frozen_string_literal: true

module FileProcessor
  module Converters
    class PdfToImage < Base
      def initialize(input_file, output_file = nil)
        super(input_file, output_file, 'jpg')
      end

      def call
        MiniMagick::Tool::Magick.new do |convert|
          convert.density ImageProcessorConfig::PDF_DENSITY
          convert << "#{input_file}[0]"
          convert << '-quality' << ImageProcessorConfig::PDF_PREVIEW_QUALITY
          convert << output_file
        end
      rescue MiniMagick::Error => e
        Loggers::Error.new("MiniMagick failed: #{e.message}", source).call
      end
    end
  end
end
