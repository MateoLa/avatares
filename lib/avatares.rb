module Avatares
  autoload :Avatarable, 'avatares/avatarable'
  autoload :ActiveRecordExtension, 'avatares/active_record_extension'

  # Method to get the avatarable in the controller
  mattr_accessor :controller_avatarable
  @@controller_avatarable = :current_user

  mattr_accessor :color 
  @@color = "#FFFFFF"
  mattr_accessor :size
  @@size = "350x350"
  mattr_accessor :font
  @@font = "DejaVu-Sans"

  def self.setup
    yield self
  end
end

require "i18n"
require "active_storage_validations"
require 'mini_magick'
require "avatares/engine"
