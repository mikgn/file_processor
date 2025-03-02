# frozen_string_literal: true

module FileProcessor
  class CLI < Thor
    desc 'process -f FILE -c COMMAND', 'Process a file (commands: preview, text, all)'
    option :f, required: true, type: :string, desc: 'Input file'
    option :c, required: false, type: :string, default: 'all', desc: 'Command (preview, text, all)'

    def self.exit_on_failure?
      true
    end

    def process
      file = options[:f]
      command = options[:c] || 'all'

      if File.exist?(file)
        Processor.new(file, command).call
      else
        puts "Error: File '#{file}' does not exist."
        exit(1)
      end
    end
  end
end
