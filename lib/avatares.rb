module Avatares
  module Models
    autoload :Avatarable, 'avatares/models/avatarable'
  end

  mattr_accessor :color
  @@color = "#FFFFFF"
  mattr_accessor :size
  @@size = "150x150"
  mattr_accessor :font
  @@font = "DejaVu-Sans"

  def self.setup
    yield self
  end

  def self.protected_attributes?
    defined?(ProtectedAttributes)
  end
end

require 'mini_magick'
require "active_storage_validations"
require "avatares/engine"
