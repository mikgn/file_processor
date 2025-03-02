# frozen_string_literal: true

RSpec.describe FileProcessor::Loggers::Base do
  let(:severity) { 'info' }
  let(:msg) { 'Test log message' }
  let(:processor_name) { 'TestProcessor' }
  let(:log_file) { 'log/test.log' }
  let(:logger) { described_class.new(severity, msg, processor_name, log_file) }

  describe '#call' do
    it 'logs to both console and file' do
      expect { logger.call }.to output(/INFO: Test log message, processor: TestProcessor/).to_stdout

      log_content = File.read(log_file)
      expect(log_content).to match(/time=\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}/)
      expect(log_content).to include('severity=info')
      expect(log_content).to include('processor=TestProcessor')
      expect(log_content).to include('message=Test log message')
    end
  end

  describe '#log_to_console' do
    it 'prints the correct message to the console' do
      expect { logger.send(:log_to_console) }.to output(/INFO: Test log message, processor: TestProcessor/).to_stdout
    end
  end

  describe '#log_to_file' do
    it 'writes the correct message to the log file' do
      logger.send(:log_to_file)

      log_content = File.read(log_file)
      expect(log_content).to match(/time=\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}/)
      expect(log_content).to include('severity=info')
      expect(log_content).to include('processor=TestProcessor')
      expect(log_content).to include('message=Test log message')
    end
  end
end
