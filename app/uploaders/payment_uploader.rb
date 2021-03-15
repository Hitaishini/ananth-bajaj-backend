class PaymentUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  #include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #process resize_to_fill: [300, 200]
  #
  # def scale(width, height)
  #   # do something
  # end
   # before_create do
   #   self.original_file = self.file.original_file
   # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :resize_to_fit => [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_white_list
  #   %w(jpg jpeg gif png pdf)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   if File.extname(original_filename).empty?
  #       if self.model.file_type == "image/jpeg"
  #             original_filename + ".jpg"
  #       elsif self.model.file_type == "text/plain" 
  #           original_filename + ".txt"
  #       elsif self.model.file_type == "application/pdf"
  #           original_filename + ".pdf"
  #       elsif self.model.file_type == "application/msword"
  #           original_filename + ".doc"
  #       elsif self.model.file_type == "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
  #           original_filename + ".docx"
  #       else
  #         original_filename + ".png"
  #       end             
  #   else
  #     original_filename 
  #   end
  # end

end
