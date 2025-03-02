# frozen_string_literal: true

RSpec.describe FileProcessor::Loggers::Info do
  let(:message) { 'Info message' }
  let(:processor_name) { 'TestProcessor' }
  subject { described_class.new(message, processor_name) }

  describe '#initialize' do
    it 'sets severity to info' do
      expect(subject.instance_variable_get(:@severity)).to eq('info')
    end
  end
end
