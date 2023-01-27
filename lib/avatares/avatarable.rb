require 'tempfile'

module Avatares 
  module Avatarable
    extend ActiveSupport::Concern

    included do
      # Has to be called before has_one_attached
      # after_ callbacks are executed in reverse order. #Rails 6
#      after_commit :resize_avatar, if: :cropping?

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
      filename = self.avatar.filename.to_s
      variation = ActiveStorage::Variation.new(crop: "#{crop_w} x #{crop_h} + #{crop_x} + #{crop_y}")
      url = ActiveStorage::Blob.service.send(:path_for, self.avatar.key)
#      url2 = ActiveStorage::Blob.service.send(:path_for, self.avatar)
      input = File.open(url)
    input2 = self.avatar.open
byebug

# message.header_image.open do |input|
#  variation.transform(input, format: "png") do |output|
#    message.cropped_header_image.attach \
#      io: output,
#      filename: "#{message.header_image.filename.base}.png",
#      content_type: "image/png"
#  end
# end

      variation.transform(input) do |output|
        self.avatar.attach io: output, filename: filename #, content_type: "image/png"
      end


#      image = MiniMagick::Image.open(self.avatar)
# byebug
#      image.crop "#{crop_w} x #{crop_h} + #{crop_x} + #{crop_y}"

#      self.avatar.attach io: StringIO.open(image.to_blob), filename: filename

byebug
    end

  end
end



