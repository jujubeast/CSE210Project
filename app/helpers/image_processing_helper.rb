require 'rubygems'
require 'mini_magick'

module ImageProcessingHelper
  class ImageProcessing
    def initialize(tmp_filename, permanent_filename)
      @base_length = 500
      
      @img_tmp_file = tmp_filename
      @img_file = permanent_filename
      
      @img = MiniMagick::Image.open(@img_tmp_file)
      @img_width = @img['width']
      @img_height = @img['height']
      
      puts "Width: " + @img_width.to_s + "\n"
      puts "height: " + @img_height.to_s + "\n"
    end
    
    def rescale_image_size
      ratio = 0.0
      if  @img_width > @img_height
        ratio = Float(@img_height) / Float(@img_width)
        puts ratio.to_s + "\n"
        @img_height = @base_length
        @img_width = Float(@base_length) / ratio
        @img_width = Integer(@img_width)
      else
        ratio = Float(@img_width) / Float(@img_height)         
        puts ratio.to_s + "\n"
        @img_width = @base_length
        @img_height = Float(@base_length) / ratio
        @img_height = Integer(@img_height)
      end

      puts "after calculation\n"
      puts "Width: " + @img_width.to_s + "\n"
      puts "height: " + @img_height.to_s + "\n"
    end
    
    def save_back_image
      puts "Hello!\n"
      puts "Hello!\n"
      puts "Hello!\n"
      puts "Hello!\n"
      puts "Hello!\n"
      puts "Hello!\n"
      puts "Hello!\n"
      puts "Hello!\n"
      puts "Hello!\n"
      puts "Hello!\n"
      
      
      new_size = @img_width.to_s + "X" + @img_height.to_s

      puts "Hello! " + new_size + "\n"
      puts "Hello! " + @img_file + "\n"
      @img.resize new_size
      puts "newsize: " + @img["width"].to_s + "\n"
      puts "newsize: " + @img["height"].to_s + "\n"
      @img.write @img_file
    end
  end
end