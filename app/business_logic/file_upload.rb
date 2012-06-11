require 'digest/sha1'

class FileUpload
  
  def initialize(uploaddata)  
    # the upload directory
    ralative_dest_dir = "data/images"
    @absolute_path = Rails.root.join("public", ralative_dest_dir)
    @uploaddata = uploaddata
    
    validate
    random_str = gen_random_string 
    @file_name = gen_random_filename(@uploaddata.original_filename, random_str)
    @tmp_file_name = gen_random_tmp_filename(@uploaddata.original_filename, random_str)
    @web_path = File.join("/" +ralative_dest_dir, @file_name)
    @tmp_file_name = File.join(@absolute_path, @tmp_file_name)
    @absolute_path = File.join(@absolute_path, @file_name)
  end

  def save_to_disk
    File.open(@tmp_file_name, "wb") do
      |f| f.write(@uploaddata.read)
    end
  end
  
  def file_name
    return @file_name
  end
  
  def tmp_file_absolute_path
    return @tmp_file_name
  end

  def file_absolute_path
    return @absolute_path
  end

  def file_web_path
    return @web_path
  end

  private
  # this will generate the random sha1 hash value
  def gen_random_string
    random_str = Digest::SHA1.hexdigest Time.now.to_s
    return random_str
  end
  
  # generate random_str.tmp.jpeg or something like that
  def gen_random_tmp_filename(original_filename, rnd_filename)
    fileext = File.extname(original_filename)
    filename_to_return = rnd_filename + ".tmp" + fileext
    return filename_to_return
  end
  
  # this generates a sha1 based file name
  # plus original extension
  def gen_random_filename(original_filename, rnd_filename)
    fileext = File.extname(original_filename)
    filename_to_return = rnd_filename + fileext
    return filename_to_return
  end
  
  # this will validte the MIME type of the uploaded file
  # we only support JPEG, PNG, and GIF file.
  def validate
    puts @uploaddata
    content_type = @uploaddata.content_type
    allowed_types = %w{image/jpeg image/png image/gif}
    if !allowed_types.include?(content_type.strip)
      filename = @uploaddata.original_filename
      contenttype = @uploaddata.content_type
      raise "file [" + filename + "] content type [" + contenttype + "] is invalid. Please upload only JPEG, PNG and GIF files."
    end
  end
end