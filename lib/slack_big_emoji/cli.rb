require 'optparse'

module SlackBigEmoji
  class CLI
    attr_accessor :options

    def initialize(args)
      @options = parse(args)
    end

    def parse(args)
      options = {}
      opts = OptionParser.new do |opts|
        opts.banner = "Usage: slack-big-emoji [options] FILE"
        opts.version = SlackBigEmoji::VERSION

        opts.on( '-f', '--file-name=NAME', 'Output filename.' ) do |val|
          options[:output_filename] = val
        end

        opts.on( '-o', '--output-dir=NAME', 'Output directory.' ) do |val|
          options[:output_dir] = val
        end

        options[:silent] = false
        opts.on( '-s', '--silent', 'Silent or quiet mode.' ) do
          options[:silent] = true
        end

        opts.on( '-w', '--width=NAME', 'Image width.' ) do |val|
          options[:width] = val
        end

        options[:convert_only] = false
        opts.on( '-c', '--convert-only', 'Convert image but do not upload.' ) do
          options[:convert_only] = true
        end

        opts.on_tail( '-h', '--help', 'Show this message' ) do
          puts opts
          exit
        end
      end
      opts.parse! # removes switches destructively, but not non-options


      file = args.first # ARGV args only - no options

      # validates input to be one image file, no gif support (yet)
      abort "Error: Missing input file" unless file
      abort "Just specify one file" if args.count > 1
      abort "Use a valid image file (png, jpeg or jpg)" if (file =~ /.\.(png|jpeg|jpg)$/).nil?

      options[:file] = file

      options
    end

    def emoji_grid(file_name)
      (@options[:width].to_i * @options[:width].to_i).times do |i|
        puts "" if i % @options[:width].to_i == 0 && i != 0
        print ":#{file_name}#{("%02d" % i)}:"
      end
      puts # madrs
    end

    def log(*msg)
      unless @options[:silent]
        if msg.size == 1
          puts msg
        else
          printf "%-20s %s\n", msg.first, msg.last
        end
      end
    end
  end
end
