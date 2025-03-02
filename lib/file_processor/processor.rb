# frozen_string_literal: true

module FileProcessor
  class Processor
    def initialize(file, command)
      @file = file
      @command = command
    end

    def call
      case command
      when 'preview'
        process_preview
      when 'text'
        process_text
      when 'all'
        process_preview
        process_text
      else
        Loggers::Error.new("Invalid command: #{command}", self.class.name).call
      end
    end

    private

    attr_reader :file, :command

    def process_preview
      case File.extname(file)
      when '.jpg', '.jpeg', '.png'
        PreviewGenerators::Image.new(file).call
      when '.pdf'
        PreviewGenerators::Pdf.new(file).call
      else
        Loggers::Error.new("Preview not supported for #{file}", self.class.name).call
      end
    end

    def process_text
      if file.end_with?('.pdf')
        Converters::PdfToText.new(file).call
      else
        Loggers::Error.new("Text extraction not supported for #{file}", self.class.name).call
      end
    end
  end
end
