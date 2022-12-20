# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'avatares/version'

Gem::Specification.new do |spec|
  spec.name          = "avatares"
  spec.version       = Avatares::VERSION
  spec.authors       = ["Mateo Laiño"]
  spec.email         = ["mateo.laino@gmail.com"]

  spec.summary       = "Gmail style avatars"
  spec.homepage      = "https://github.com/mateola/avatares"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'rails'
  spec.add_dependency "mini_magick"      # Ruby interface for ImageMagick
  spec.add_dependency "inline_svg"
  spec.add_dependency "active_storage_validations"

  spec.add_development_dependency "rspec-rails"
end
