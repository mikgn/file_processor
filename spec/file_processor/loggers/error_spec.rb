# frozen_string_literal: true

RSpec.describe FileProcessor::Loggers::Error do
  let(:message) { 'Error message' }
  let(:processor_name) { 'TestProcessor' }
  subject { described_class.new(message, processor_name) }

  describe '#initialize' do
    it 'sets severity to error' do
      expect(subject.instance_variable_get(:@severity)).to eq('error')
    end
  end
end
