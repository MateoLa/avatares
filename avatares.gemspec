$:.push File.expand_path("lib", __dir__)

require 'avatares/version'

Gem::Specification.new do |spec|
  spec.platform      = Gem::Platform::RUBY  
  spec.name          = "avatares"
  spec.version       = Avatares::VERSION
  spec.summary       = "Gmail style avatars"
  spec.description   = "Adds an avatar to any model (usually the user account)."

  spec.authors       = ["Mateo Laiño"]
  spec.email         = ["mateo.laino@gmail.com"]
  spec.homepage      = "https://github.com/mateola/avatares"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "http://github.com/MateoLa/avatares"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files = Dir["{app,config,db,lib}/**/*", "LICENSE", "Rakefile", "README.md"]

  spec.add_dependency 'rails'
#  spec.add_dependency 'jquery-rails'
#  spec.add_dependency 'jquery-ui-rails', '>= 4.0.0'
#  spec.add_dependency 'bootstrap', '~> 4.0'
  spec.add_dependency 'i18n'
  spec.add_dependency "active_storage_validations"
  spec.add_dependency "image_processing"
  spec.add_dependency "mini_magick"      # Ruby interface for ImageMagick

  spec.add_development_dependency "rspec-rails"
end
