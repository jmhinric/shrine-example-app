require "image_processing/mini_magick"

class ImageUploader < Shrine
  include ImageProcessing::MiniMagick
  # plugin :store_dimensions
  plugin :logging
  plugin :determine_mime_type
  plugin :processing
  plugin :versions   # enable Shrine to handle a hash of files
  # plugin :validation_helpers

  # Attacher.validate do
    # validate_max_size 5*1024*1024, message: "is too large (max is 5 MB)"
    # validate_mime_type_inclusion ["application/pdf"]
  # end

  process(:store) do |io, context|
    original = io.download

    size_800 = resize_to_limit!(original, 800, 800)
    size_500 = resize_to_limit(size_800,  500, 500)
    size_300 = resize_to_limit(size_500,  300, 300)

    {original: io, large: size_800, medium: size_500, small: size_300}
  end
end
