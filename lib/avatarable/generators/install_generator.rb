require 'rails/generators'

module Avatarable
  module Generators
    class InstallGenerator < ::Rails::Generators::Base

      source_root File.expand_path('../templates', __FILE__)

      def create_initializer_file
        template 'initializer.rb', 'config/initializers/avatarable.rb'
      end

    end
  end
end
