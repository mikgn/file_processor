# frozen_string_literal: true

module FileProcessor
  module PreviewGenerators
    class Base
      def initialize(file, output_ext = 'jpg')
        @file = file
        @output_ext = output_ext
      end

      def call
        output_file = Utils::FileNameBuilder.new(file, output_ext).call

        FileUtils.mkdir_p(File.dirname(output_file))

        generate_preview(output_file)

        Loggers::Info.new("Generated preview: #{output_file}", source).call
      end

      private

      attr_reader :file, :output_ext

      def generate_preview(_output_file)
        raise NotImplementedError, "#{self.class.name} must implement `generate_preview`"
      end

      def source
        self.class.name
      end
    end
  end
end
