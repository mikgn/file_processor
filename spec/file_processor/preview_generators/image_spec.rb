# frozen_string_literal: true

require 'spec_helper'

RSpec.describe FileProcessor::PreviewGenerators::Image do
  describe '#generate_preview' do
    it 'resizes the image' do
      file = './data/sample/sample_jpg.jpg'
      image_preview = FileProcessor::PreviewGenerators::Image.new(file)

      expect_any_instance_of(FileProcessor::Utils::ImageResizer).to receive(:call)

      image_preview.call
    end
  end
end
