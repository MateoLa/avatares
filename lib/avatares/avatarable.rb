module Avatares 
  module Avatarable
    extend ActiveSupport::Concern

    included do
      has_one_attached :avatar, dependent: :destroy_async
      validates :avatar, content_type: ['image/png', 'image/jpg', 'image/jpeg'], size: { less_than: 5.megabytes }
      before_save :resize_avatar
      after_commit :generate_default_avatar
    end

    attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
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

    def resize_avatar
      return unless avatar && crop_x && crop_y && crop_w && crop_h
      image = MiniMagick::Image.new(avatar)
      image.crop "#{crop_w} x #{crop_h} + #{crop_x} + #{crop_y}"
      avatar = image
byebug
    end

  end
end
