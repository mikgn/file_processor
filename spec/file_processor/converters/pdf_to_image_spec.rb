# frozen_string_literal: true

RSpec.describe FileProcessor::Converters::PdfToImage do
  let(:input_file) { './data/sample/input.pdf' }
  let(:output_file) { './data/preview/output.jpg' }

  subject(:converter) { described_class.new(input_file, output_file) }

  describe '#initialize' do
    it 'sets the output extension to jpg' do
      expect(converter.instance_variable_get(:@output_file)).to end_with('.jpg')
    end
  end

  describe '#call' do
    it 'executes MiniMagick' do
      expect { converter.call }.not_to raise_error
    end

    context 'when MiniMagick raises an error' do
      before do
        allow(MiniMagick::Tool::Magick).to receive(:new).and_raise(MiniMagick::Error, 'conversion failed')
      end

      it 'logs the error' do
        allow(FileProcessor::Loggers::Error).to receive(:new).and_return(double(call: nil))
        converter.call
        expect(FileProcessor::Loggers::Error).to have_received(:new).with('MiniMagick failed: conversion failed', described_class.name).once
      end
    end
  end
end
