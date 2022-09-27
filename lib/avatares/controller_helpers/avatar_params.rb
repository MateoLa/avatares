module Avatares
  module ControllerHelpers
    module AvatarParams
      extend ActiveSupport::Concern

      included do
        before_save :rescue_avatar_params, if: self.acts_as_avatarable?
      end

      rescue_from ActiveRecord::RecordNotFound, with: :resource_not_found

      def rescue_avatar_params
binding.pry
        self.permit.params[:avatar]
      end

      protected

      def resource
        return @resource if @resource
    
        parent_model_name = parent_data[:model_name] if parent_data
        @resource = Spree::Admin::Resource.new controller_path, controller_name, parent_model_name, object_name
      end

      def model_class
        @model_class ||= resource.model_class
      end
    
      def resource_not_found
        flash[:error] = I18n.t(:not_found, resource: model_class)
        redirect_to collection_url
      end

      def load_resource
        @object ||= load_resource_instance
        instance_variable_set("@#{resource.object_name}", @object)
      end

      def load_resource_instance
        model_class.find(params[:id]) if params[:id]
      end

    end
  end
end
