require "image_processing/mini_magick" # for image processing and versions plugin

class ImageUploader < Shrine
  include ImageProcessing::MiniMagick # for image processing and versions plugin
  plugin :processing # for image processing and versions plugin
  plugin :versions   # image processing - enable Shrine to handle a hash of files

  # plugin :store_dimensions # extract image dimensions- throws -- fastimage error if used with versions plugin?

  plugin :validation_helpers
  Attacher.validate do
    validate_max_size 2*1024*1024, message: "is too large (max is 5 MB)"
    # validate_mime_type_inclusion ["application/pdf"]
  end

  process(:store) do |io, context|
    original = io.download

    size_800 = resize_to_limit!(original, 800, 800)
    size_500 = resize_to_limit(size_800,  500, 500)
    size_300 = resize_to_limit(size_500,  300, 300)

    {original: io, large: size_800, medium: size_500, small: size_300}
  end
end
