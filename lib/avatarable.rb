module Avatarable
  module Models
    autoload :Avatarable, 'avatarable/models/avatarable'
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
end

require 'mini_magick'
require "avatarable/engine"
require "avatarable/models/avatar"
