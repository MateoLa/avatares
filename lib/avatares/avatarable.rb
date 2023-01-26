require 'tempfile'

module Avatares 
  module Avatarable
    extend ActiveSupport::Concern

    include Rails.application.routes.url_helpers

    included do
      has_one_attached :avatar, dependent: :destroy_async do |attachable|
        attachable.variant :small, resize: Avatares.styles[:small]
        attachable.variant :medium, resize: Avatares.styles[:medium]
        attachable.variant :large, resize: Avatares.styles[:large]
      end
      validates :avatar, content_type: ['image/png', 'image/jpg', 'image/jpeg'], size: { less_than: 5.megabytes }
      before_commit :resize_avatar, if: :cropping?
      after_commit :generate_default_avatar
    end

    attr_accessor :crop_x, :crop_y, :crop_w, :crop_h

    def avatar_string
      raise NotImplementedError, "must implement avatar_string in your Avatarable model"
    end

    def cropping?
      crop_x.present? && crop_y.present? && crop_w.present? && crop_h.present?
    end

    private

    def generate_default_avatar
      DefaultAvatar.new(self, avatar_string).call unless avatar.attached?
    end
    
    def resize_avatar
#      picture = Tempfile.new ["picture", ".png"], binmode: true
# byebug

#      uploaded = params[:ticket][:uploaded_file]
#      File.open(picture, 'w') do |file|
#        file.write(self.avatar)
#      end

byebug
#      avatar_path = self.avatar.attachable
#      av_path = self.avatar.attachable.read
      image = MiniMagick::Image.from_blob(self.avatar.url)
byebug
      image.crop "#{crop_w} x #{crop_h} + #{crop_x} + #{crop_y}"
      self.avatar = image
# byebug
    end

  end
end
