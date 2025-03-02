# frozen_string_literal: true

require 'spec_helper'

RSpec.describe FileProcessor::Converters::PdfToText do
  let(:input_file) { 'spec/fixtures/input.pdf' }
  let(:output_file) { 'spec/fixtures/output.txt' }
  let(:text_content) { "Page 1 text\nPage 2 text" }

  subject(:converter) { described_class.new(input_file, output_file) }

  describe '#initialize' do
    it 'sets the output extension to txt' do
      expect(converter.instance_variable_get(:@output_file)).to end_with('.txt')
    end
  end

  describe '#call' do
    let(:reader) { instance_double(PDF::Reader, pages: pages) }
    let(:pages) { [instance_double(PDF::Reader::Page, text: 'Page 1 text'), instance_double(PDF::Reader::Page, text: 'Page 2 text')] }

    before do
      allow(PDF::Reader).to receive(:new).with(input_file).and_return(reader)
      allow(File).to receive(:write)
      allow(FileProcessor::Loggers::Info).to receive(:new).and_return(double(call: nil))
    end

    it 'extracts text from PDF and writes to file' do
      converter.call
      expect(File).to have_received(:write).with(output_file, text_content)
    end

    it 'logs the success' do
      converter.call
      expect(FileProcessor::Loggers::Info).to have_received(:new).with("Extracted text: #{output_file}", described_class.name).once
    end

    context 'when PDF is malformed' do
      before do
        allow(PDF::Reader).to receive(:new).and_raise(PDF::Reader::MalformedPDFError, 'invalid pdf')
        allow(FileProcessor::Loggers::Error).to receive(:new).and_return(double(call: nil))
      end

      it 'logs the error twice' do
        converter.call
        expect(FileProcessor::Loggers::Error).to have_received(:new).with('PDF Reader error: invalid pdf', described_class.name).twice
      end
    end
  end
end
