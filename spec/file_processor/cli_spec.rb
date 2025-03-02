# frozen_string_literal: true

RSpec.describe FileProcessor::CLI do
  let(:cli) { described_class.new }

  describe '#process' do
    context 'when the file exists' do
      let(:file) { 'data/sample/sample_test_pdf.pdf' }

      before do
        File.open(file, 'w') { |f| f.puts('Dummy content') }
      end

      after do
        File.delete(file)
      end

      it 'calls Processor with the correct arguments' do
        cli.options = { f: file, c: 'all' }
        allow(FileProcessor::Processor).to receive(:new).and_return(double(call: nil))
        cli.process

        expect(FileProcessor::Processor).to have_received(:new).with(file, 'all')
      end

      it 'calls Processor with default command when not specified' do
        cli.options = { f: file }
        allow(FileProcessor::Processor).to receive(:new).and_return(double(call: nil))
        cli.process

        expect(FileProcessor::Processor).to have_received(:new).with(file, 'all')
      end
    end

    context 'when the file does not exist' do
      let(:file) { 'data/sample/invalid_name_pdf.pdf' }

      it 'prints an error message and exits with status 1' do
        cli.options = { f: file }
        expect { cli.process }.to output("Error: File '#{file}' does not exist.\n").to_stdout
      end
    end
  end

  describe '#exit_on_failure?' do
    it 'returns true' do
      expect(FileProcessor::CLI.exit_on_failure?).to be true
    end
  end
end
