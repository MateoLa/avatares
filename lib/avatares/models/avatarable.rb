module Avatares
  module Models
    module Avatarable
      extend ActiveSupport::Concern

      module ActiveRecordExtension
        #Converts the model into avatarable allowing to call "model".avatar
        def acts_as_avatarable
          include Avatarable
        end
      end

      included do
        has_one_attached :avatar, dependent: :destroy_async
        validates :avatar, content_type: ['image/png', 'image/jpg', 'image/jpeg'], size: { less_than: 5.megabytes }
        after_save :generate_avatar
      end

      attr_accessor :avatar_img_del

      def avatar_string
        raise NotImplementedError, "must implement avatar_string in your Avatarable model"
      end

      def generate_avatar
        return if avatar.attached?
        Avatar.new(self, avatar_string).call
      end

      def avatarable?
        true
      end
    end
  end
end
