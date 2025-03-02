# frozen_string_literal: true

require 'fileutils'
require 'mini_magick'
require 'pdf-reader'
require 'thor'

Dir[File.join(__dir__, 'file_processor', '**', '*.rb')].each { |file| require_relative file }

require_relative '../config/image_processor'

module FileProcessor; end
