module Avatares
  class Engine < Rails::Engine
    initializer "avatares.models.avatarable" do
      ActiveSupport.on_load(:active_record) do
        extend Avatares::Models::Avatarable::ActiveRecordExtension
      end
    end
  end
end