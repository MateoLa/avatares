class AvatarsController < ApplicationController
  include AvatarsHelper

  before_action :load_avatarable, on: [:update, :delete]

  def update
    if @avatarable.update(avatar_params)
      flash[:success] = t(:avatar_updated)
    elsif @avatarable.errors[:avatar]
      flash[:error] = @avatarable.errors[:avatar].join(". ")
    else
      flash[:error] = t(:avatar_error)
    end
    redirect_to request.referrer || root_path
  end
  
  def destroy
    @resource.avatar.purge
    redirect_to request.referrer || root_path
  end
  
  private
  
  def load_avatarable
    @avatarable ||= send Avatares.avatarable_instance
  end
  
  def avatar_params
byebug
    params.require(@avatarable.class.to_s.underscore).permit(:avatar)
  end
end