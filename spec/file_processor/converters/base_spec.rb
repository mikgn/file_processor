# frozen_string_literal: true

require 'spec_helper'

RSpec.describe FileProcessor::Converters::Base do
  let(:input_file) { 'spec/fixtures/input.pdf' }
  let(:output_ext) { 'txt' }
  let(:output_file) { 'spec/fixtures/output.txt' }

  subject(:base) { described_class.new(input_file, output_file, output_ext) }

  describe '#initialize' do
    context 'when output_file is provided' do
      it 'uses the provided output_file' do
        expect(base.send(:output_file)).to eq(output_file)
      end
    end

    context 'when output_file is not provided' do
      let(:output_file) { nil }
      let(:generated_name) { 'generated.txt' }

      before do
        builder = instance_double(FileProcessor::Utils::FileNameBuilder, call: generated_name)
        allow(FileProcessor::Utils::FileNameBuilder).to receive(:new).with(input_file, output_ext).and_return(builder)
      end

      it 'generates output_file using FileNameBuilder' do
        expect(base.send(:output_file)).to eq(generated_name)
      end
    end
  end

  describe '#call' do
    it 'raises NotImplementedError' do
      expect { base.call }.to raise_error(NotImplementedError)
    end
  end

  describe '#source' do
    it 'returns the class name' do
      expect(base.send(:source)).to eq(described_class.name)
    end
  end
end
