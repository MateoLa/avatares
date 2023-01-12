module Avatares
  autoload :Avatarable, 'avatares/avatarable'
  autoload :ActiveRecordExtension, 'avatares/active_record_extension'

  # Method to get the avatarable in the controller
  mattr_accessor :controller_avatarable
  @@controller_avatarable = :current_user

  # Default styles to be generated
  mattr_accessor :avatarable_styles
  @@avatarable_styles = { small:  '50x50',
                          medium: '120x120',
                          large: '260x260' }

  mattr_accessor :font
  @@font = "DejaVu-Sans"

  def self.setup
    yield self
  end
end

require "active_storage_validations"
require 'mini_magick'
require "avatares/engine"
