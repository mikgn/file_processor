# frozen_string_literal: true

module FileProcessor
  module Converters
    class PdfToText < Base
      def initialize(input_file, output_file = nil)
        super(input_file, output_file, 'txt')
      end

      def call
        text = PDF::Reader.new(input_file).pages.map(&:text).join("\n")

        File.write(output_file, text)

        Loggers::Info.new("Extracted text: #{output_file}", source).call
      rescue PDF::Reader::MalformedPDFError => e
        Loggers::Error.new("PDF Reader error: #{e.message}", source).call
        Loggers::Error.new("PDF Reader error: #{e.message}", source).call
      end
    end
  end
end
