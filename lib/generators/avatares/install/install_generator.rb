require 'rails/generators'

module Avatares
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)

      def create_avatares_initializer_file
        template 'initializer.rb', 'config/initializers/avatares.rb'
      end

      def add_avatares_routes
        insert_into_file(File.join('config', 'routes.rb'), :before => /^end\b/) do
          <<-ROUTES.strip_heredoc.indent!(2)
            # Avatares routes.
            mount Avatares::Engine, at: '/avatares'
          ROUTES
        end
      end

    end
  end
end
