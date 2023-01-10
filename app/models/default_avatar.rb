require 'tempfile'

class DefaultAvatar

  # "Material Design Colors" work well with white text. 
  BG_COLORS = [ "#e53935", "#b71c1c", "#d81b60", "#880e4f", "#8e24aa", "#4a148c",
    "#5e35b1", "#311b92", "#3949ab", "#1a237e", "#1e88e5", "#0d47a1", "#039be5", "#01579b",
    "#00acc1", "#006064", "#00897b", "#004d40", "#43a047", "#1b5e20", "#7cb342", "#33691e",
    "#c0ca33", "#827717", "#fdd835", "#f57f17", "#ffb300", "#ff6f00", "#fb8c00", "#e65100",
    "#f4511e", "#bf360c", "#6d4c41", "#3e2723", "#757575", "#212121", "#546e7a", "#263238" ].freeze

  # An "initials" Avatar is generated by extracting the first letter of the first 3 words in string.
  def initialize(model, string)
    @model = model

    # defaults
    @color       = Avatares.color
    @size        = Avatares.size
    @font        = Avatares.font

    # extract the first letter of the first 3 words and capitalize
    @text = (string.split(/\s/)- ["", nil]).map { |t| t[0].upcase }.slice(0, 3).join('')

    w, h = @size.split('x').map { |d| d.to_i }
    @font_size = ( w / [@text.length, 2].max ).to_i
  end

  def call
    # Create a temporary file for an output image
    avatar_image = Tempfile.new ["avatar", ".png"], binmode: true

    MiniMagick::Tool::Convert.new do |image|
      image.size @size
      image.gravity "center"
      image.xc avatar_bg
      image.antialias
      image.pointsize @font_size
      image.font @font
      image.fill @color
      image.draw "text 0,0 #{@text}"
      image << avatar_image.path
    end

    @model.avatar.attach io: File.open(avatar_image), filename: "avatar-#{@model.id}.png", content_type: 'image/png'
    avatar_image.close
  end

  private
    
  # We don’t care which colour is chosen for the avatar background but we need to be consistent.
  # If we simply call AVATAR_COLORS.sample, a random but different value will be returned everytime.
  # To ensure consistency, we use the Zlib library to calculate the crc checksum of a string returned by avatar_param.
  # The modulo operation on the checksum ensure we’re in the bounds of our array of colours.
  def avatar_bg
    BG_COLORS[Zlib.crc32(avatar_param).modulo(BG_COLORS.length)]
  end

  # to_param returns the model’s id stringified.
  def avatar_param
    @model.to_param
  end
end
