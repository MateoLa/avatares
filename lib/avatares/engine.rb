module Avatares
  class Engine < Rails::Engine
    engine_name 'avatares'

    initializer "avatares.avatarable" do
      ActiveSupport.on_load(:active_record) do
        extend Avatares::ActiveRecordExtension
      end
    end

    initializer "avatares.assets.precompile" do |app|
      app.config.assets.precompile += %w( images/*.svg )
    end
  end
end