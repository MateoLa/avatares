module Avatarable
  class Engine < Rails::Engine
    initializer "initials_avatar.models.avatarable" do
      ActiveSupport.on_load(:active_record) do
        extend Avatarable::Models::Avatarable::ActiveRecordExtension
      end
    end
  end
end