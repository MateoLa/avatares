module Avatares 
  module Avatarable
    extend ActiveSupport::Concern

    included do
      # Has to be called before "has_one_attached" (after_ callbacks are executed in reverse order)
      after_commit :resize_avatar, if: :cropping?
      has_one_attached :avatar, dependent: :destroy_async
      
      after_save :generate_default_avatar

      attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
      validates :avatar, content_type: ['image/png', 'image/jpg', 'image/jpeg'], size: { less_than: 5.megabytes }
    end

    def avatar_string
      raise NotImplementedError, "must implement avatar_string in your Avatarable model"
    end

    def cropping?
      crop_x.present? && crop_y.present? && crop_w.present? && crop_h.present?
    end

    private

    def generate_default_avatar
      return if avatar.attached?
      DefaultAvatar.new(self, avatar_string).call
    end
    
    def resize_avatar
      filename = self.avatar.filename.to_s
      size = Avatares.size.split('x').map(&:to_i)
      area = [self.crop_x.to_i, self.crop_y.to_i, self.crop_w.to_i, self.crop_h.to_i]

      variation = ActiveStorage::Variation.new(
        crop: area,
        resize_to_fit: size
      )
      self.crop_w = self.crop_h = self.crop_x = self.crop_y = nil    # Avoiding an infinite loop

      url = ActiveStorage::Blob.service.send(:path_for, self.avatar.key)
      input = File.open(url)

      variation.transform(input) do |output|
        self.avatar.attach io: output, filename: filename
      end
    end

  end
end

### Rails 6, 7 ###
# Modifying the attachment presents the following difficulties:
#
## Before Callbacks:
#    It cannot be done using before_ callbacks because the file is not available or accessible at this moment.
#    ActiveStorage::Blob.service.send(:path_for, self.avatar.key) FAILS.
#
## After Callbacks:
#    To the file being avilable the callback has to be called before "has_one_attached"
#    after_ callbacks are executed in reverse order, so the orther of the sentences matters
#    --> after_commit :resize_avatar, if: :cropping?
#    --> has_one_attached :avatar
#    But, attaching the avatar in an after_ callback would cause an infinite loop,
#    so you need to prevent this to happen.  
