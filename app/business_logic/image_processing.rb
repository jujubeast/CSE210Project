require 'rubygems'
require 'mini_magick'

class ImageProcessing
  def initialize(tmp_filename, permanent_filename)
    @base_length = 500
    
    @img_tmp_file = tmp_filename
    @img_file = permanent_filename

    @img = MiniMagick::Image.open(@img_tmp_file)

    @img_width = @img['width']
    @img_height = @img['height']
  end
  
  def rescale_image_size
    ratio = 0.0
    if  @img_width < @img_height
      ratio = Float(@img_height) / Float(@img_width)
      @img_height = @base_length
      @img_width = Float(@base_length) / ratio
      @img_width = Integer(@img_width)
    else
      ratio = Float(@img_width) / Float(@img_height)         
      @img_width = @base_length
      @img_height = Float(@base_length) / ratio
      @img_height = Integer(@img_height)
    end
  end
  
  def save_back_image
    new_size = @img_width.to_s + "X" + @img_height.to_s
    @img.resize new_size
    @img.write @img_file
  end
end
