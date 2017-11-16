require 'image_processing/mini_magick'

class ImageUploader < Shrine
  include ImageProcessing::MiniMagick
  plugin :processing
  plugin :versions
  plugin :delete_raw

  process(:store) do |io, _context|
    original = io.download

    thumb = resize_to_limit(original, 270, 270)

    { original: io, thumb: thumb }
  end
end
