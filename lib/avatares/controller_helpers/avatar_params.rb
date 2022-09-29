module Avatares
  module ControllerHelpers
    module AvatarParams
      extend ActiveSupport::Concern

      included do
        before_action :save_avatar, only: :update, if: :resource_avatarable?
        rescue_from ActiveRecord::RecordNotFound, with: :resource_not_found
      end

      def save_avatar
        if params[model_name][:avatar]
          resource.avatar = params[model_name][:avatar]
          resource.save
          params[model_name].delete :avatar
        end
      end

      private

      def resource_avatarable?
        resource&.avatarable?
      end

      def resource
        @resource ||= load_resource_instance
      end

      def load_resource_instance
        model_class.find_by_id(params[:id]) if params[:id]
      end

      def model_class
        parts = controller_path.split('/')
        gem_part = parts[0].capitalize if parts.length > 1
        gem_part = "#{gem_part}::" unless gem_part.empty?
        @model_class ||= "#{gem_part}#{controller_name.classify}".constantize
      end

      def model_name
        @omodel_name ||= controller_name.singularize
      end

      def resource_not_found
        flash[:error] = I18n.t(:not_found, resource: model_class, scope: :avatarable)
        redirect_to request.referrer
      end

    end
  end
end
