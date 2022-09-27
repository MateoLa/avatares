# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'avatarable/version'

Gem::Specification.new do |spec|
  spec.name          = "avatar_span"
  spec.version       = Avatarable::VERSION
  spec.authors       = ["Mateo Laiño"]
  spec.email         = ["mateo.laino@gmail.com"]

  spec.summary       = "Gmail style avatars"
  spec.homepage      = "https://github.com/mateola/avatarable"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "mini_magick"      # Ruby interface for ImageMagick
end
