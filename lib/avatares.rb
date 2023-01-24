module Avatares
  autoload :Avatarable, 'avatares/avatarable'
  autoload :ActiveRecordExtension, 'avatares/active_record_extension'

  # Method to get the avatarable in the controller
  mattr_accessor :avatarable_instance
  @@avatarable_instance = :current_user

  # Default image styles to use by the app
  mattr_accessor :styles
  @@styles = { small:  '50x50',
               medium: '200x200',
               large: '350x350' }

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

require 'bootstrap'
require 'jquery-rails'
require 'jquery-ui-rails'
require "i18n"
require "active_storage_validations"
require 'mini_magick'
require "avatares/engine"
