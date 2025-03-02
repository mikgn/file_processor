# frozen_string_literal: true

RSpec.describe FileProcessor::Processor do
  describe '#call' do
    context 'when command is preview' do
      it 'calls process_preview' do
        file = './data/sample/sample_jpg.jpg'
        processor = FileProcessor::Processor.new(file, 'preview')

        expect(processor).to receive(:process_preview)
        processor.call
      end
    end

    context 'when command is text' do
      it 'calls process_text' do
        file = './data/sample/sample_pdf.pdf'
        processor = FileProcessor::Processor.new(file, 'text')

        expect(processor).to receive(:process_text)
        processor.call
      end
    end

    context 'when command is all' do
      it 'calls both process_preview and process_text' do
        file = './data/sample/sample_pdf.pdf'
        processor = FileProcessor::Processor.new(file, 'all')

        expect(processor).to receive(:process_preview)
        expect(processor).to receive(:process_text)
        processor.call
      end
    end

    context 'when command is invalid' do
      it 'logs an error' do
        file = './data/sample/sample_pdf.pdf'
        processor = FileProcessor::Processor.new(file, 'invalid_command')

        expect(FileProcessor::Loggers::Error).to receive(:new).with('Invalid command: invalid_command',
                                                                    FileProcessor::Processor.name).and_call_original
        processor.call
      end
    end
  end
end
