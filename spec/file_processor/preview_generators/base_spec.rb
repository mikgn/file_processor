# frozen_string_literal: true

require 'spec_helper'

RSpec.describe FileProcessor::PreviewGenerators::Base do
  describe '#call' do
    it 'generates a preview and logs the info' do
      file = './data/sample/sample_jpg.jpg'
      base = FileProcessor::PreviewGenerators::Base.new(file)

      allow(FileUtils).to receive(:mkdir_p)
      expect(base).to receive(:generate_preview)

      expect { base.call }.to output(/Generated preview:/).to_stdout
    end
  end
end
