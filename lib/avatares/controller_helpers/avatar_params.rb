module Avatares
  module ControllerHelpers
    module AvatarParams
      extend ActiveSupport::Concern

      included do
        before_save :permit_avatar_params, if: object.acts_as_avatarable?
      end

      def permit_avatar_params
        object.permit.params[:avatar]
      end
    end
  end
end
