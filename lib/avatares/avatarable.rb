module Avatares 
  module Avatarable
    extend ActiveSupport::Concern

    included do
      has_one_attached :avatar, dependent: :destroy_async do |attachable|
        attachable.variant :small, resize: Avatares.styles[:small]
        attachable.variant :medium, resize: Avatares.styles[:medium]
        attachable.variant :large, resize: Avatares.styles[:large]
      end

      validates :avatar, content_type: ['image/png', 'image/jpg', 'image/jpeg'], size: { less_than: 5.megabytes }
#      after_commit :generate_default_avatar
    end

    attr_accessor :avatar_img_del

    def avatar_string
      raise NotImplementedError, "must implement avatar_string in your Avatarable model"
    end

    def generate_default_avatar
      return if avatar.attached?
      DefaultAvatar.new(self, avatar_string).call
    end
    
    def avatarable?
      true
    end
  end
end
