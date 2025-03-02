# frozen_string_literal: true

module FileProcessor
  module PreviewGenerators
    class Pdf < Base
      private

      def generate_preview(output_file)
        Converters::PdfToImage.new(file, output_file).call
      end
    end
  end
end
