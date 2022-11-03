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
      after_commit :generate_default_avatar
    end

    attr_accessor :avatar_img_del

    def avatar_string
      raise NotImplementedError, "must implement avatar_string in your Avatarable model"
    end

    def generate_default_avatar
      return if avatar.attached?
      Avatarable::DefaultAvatar.call(self, avatar_string)
    end
  
    def avatarable?
      true
    end
  end

