require 'rails/generators'

module Avatares
  module Generators
    class InstallGenerator < ::Rails::Generators::Base

      source_root File.expand_path('../templates', __FILE__)

      def create_initializer_file
        template 'initializer.rb', 'config/initializers/avatares.rb'
      end

    end
  end
end
