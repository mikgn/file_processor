# frozen_string_literal: true

RSpec.describe FileProcessor::PreviewGenerators::Pdf do
  describe '#generate_preview' do
    it 'converts PDF to image' do
      file = './data/sample/sample_pdf.pdf'
      pdf_preview = FileProcessor::PreviewGenerators::Pdf.new(file)

      expect_any_instance_of(FileProcessor::Converters::PdfToImage).to receive(:call)

      pdf_preview.call
    end
  end
end
