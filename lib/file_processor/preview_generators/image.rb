# frozen_string_literal: true

module FileProcessor
  module PreviewGenerators
    class Image < Base
      private

      def generate_preview(output_file)
        Utils::ImageResizer.new(file, output_file).call
      end
    end
  end
end
