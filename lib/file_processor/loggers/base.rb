# frozen_string_literal: true

module FileProcessor
  module Loggers
    class Base
      def initialize(severity, msg, processor_name, log_file = 'log/development.log')
        @severity = severity
        @msg = msg
        @processor_name = processor_name
        @log_file = log_file
      end

      def call
        log_to_console
        log_to_file
      end

      def log_to_console
        puts "#{severity.upcase}: #{msg}, processor: #{processor_name}"
      end

      private

      attr_reader :severity, :msg, :processor_name, :log_file

      def log_to_file
        File.open(log_file, 'a') do |f|
          f.puts "time=#{Time.now.strftime('%Y-%m-%d %H:%M:%S')} severity=#{severity}" \
                 " processor=#{processor_name} message=#{msg}"
        end
      end
    end
  end
end
