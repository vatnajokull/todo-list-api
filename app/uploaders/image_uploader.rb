class ImageUploader < Shrine
  include ImageProcessing::MiniMagick

  plugin :processing
  plugin :validation_helpers
  plugin :versions
  plugin :remove_invalid
  plugin :determine_mime_type

  Attacher.validate do
    validate_max_size 10 * 1024 * 1024, message: I18n.t('comment.validation.file_max_size')
    validate_mime_type_inclusion %w[image/jpeg image/jpg image/png]
  end

  process(:store) do |io, _context|
    original = io.download

    thumb = resize_to_limit(original, 270, 270)
    { original: io, thumb: thumb }
  end
end
