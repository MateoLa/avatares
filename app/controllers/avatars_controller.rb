module Avatares
  class AvatarsController < ApplicationController
    include AvatarsHelper

    rescue_from ActiveRecord::RecordNotFound, with: :resource_not_found
    before_action :load_resource, on: [:update, :delete], if: :resource_avatarable?
  
    def update
      if @resource.update(avatar_params)
        flash[:success] = t(:avatar_updated)
      elsif @resource.errors[:avatar]
        flash[:error] = @resource.errors[:avatar].join(". ")
      else
        flash[:error] = t(:avatar_error)
      end
      redirect_to request.referrer
    end
  
    def delete
      @resource.avatar.purge
      redirect_to request.referrer
    end
  
    private
  
    def avatar_params
      params.require(:avatar).permit
    end
  
    def load_resource
      @resource ||= resource
      authorize! params[:action].to_sym, @resource
    end
  
  end
end