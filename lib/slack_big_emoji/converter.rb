require 'mini_magick'
require_relative 'uploader'

module SlackBigEmoji
  class Converter
    attr_accessor :image, :file_name, :ratio, :file_resize_spec, :tile_width, :crop_size, :output_dir, :output_filename, :output_path

    def initialize(options={})
      @image = ::MiniMagick::Image.open(options[:file])
      @file_name = File.basename(options[:file], ".*")
      @ratio = @image[:width].to_f/@image[:height].to_f
      @file_resize_spec = '640x640'
      @tile_width = 5
      @crop_size = '128x128'
      @output_dir = options[:output_dir] || @file_name
      @output_filename = options[:output_filename] || @file_name
      @output_path = "#{@output_dir}/#{@output_filename}%02d.png"
    end

    def valid?
      return @ratio == 1
    end

    def convert
      convert_opts = ["-resize", @file_resize_spec, "-crop", @crop_size]
      Dir.mkdir(@output_dir) unless File.exists?(@output_dir)
      ::MiniMagick::Tool::Convert.new do |convert|
        convert << @image.path
        convert.merge! convert_opts
        convert << @output_path
      end
    end
  end
end
