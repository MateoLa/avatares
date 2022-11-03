module Avatares
  class Engine < Rails::Engine
    engine_name 'avatares'

    initializer "avatares.models.avatarable" do
      ActiveSupport.on_load(:active_record) do
        extend Avatares::Avatarable::ActiveRecordExtension
      end
    end

    config.to_prepare do
      Dir.glob(File.join(File.dirname(__FILE__), "../../app/**/*_decorator.rb")) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end
  end
end