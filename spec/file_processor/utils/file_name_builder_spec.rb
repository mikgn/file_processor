# frozen_string_literal: true

RSpec.describe FileProcessor::Utils::FileNameBuilder do
  describe '#call' do
    it 'generates a valid file name for the preview' do
      file = './data/sample/sample_jpg.jpg'
      file_name_builder = FileProcessor::Utils::FileNameBuilder.new(file)

      expected_file_name = "#{ImageProcessorConfig::PREVIEW_DIR}sample_jpg_preview_#{Time.now.to_i}.jpg"
      allow(Time).to receive(:now).and_return(Time.at(1_234_567_890)) # For deterministic testing

      expect(file_name_builder.call).to eq(expected_file_name)
    end
  end
end
