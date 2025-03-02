# frozen_string_literal: true

RSpec.describe FileProcessor::Utils::ImageResizer do
  let(:input_file) { 'data/sample/sample_jpg.jpg' }
  let(:output_file) { 'data/preview/test_resized_sample.jpg' }
  let(:resizer) { described_class.new(input_file, output_file) }

  after do
    File.delete(output_file) if File.exist?(output_file)
  end

  describe '#call' do
    context 'when MiniMagick executes successfully' do
      it 'resizes the image and creates the output file' do
        resizer.call

        expect(File.exist?(output_file)).to be true
      end
    end

    context 'when MiniMagick raises an error' do
      before do
        allow(MiniMagick::Image).to receive(:open).and_raise(MiniMagick::Error, 'Resizing failed')
        allow(FileProcessor::Loggers::Error).to receive(:new).and_return(double(call: true))
      end

      it 'logs the error' do
        expect { resizer.call }.not_to raise_error
      end
    end
  end
end
