class AvatarsController < ApplicationController
  before_action :load_avatarable, on: [:update, :delete]

  def update
    if @avatarable.update(avatar_params)
      flash[:success] = t(:avatar_updated, scope: :avatares)
    elsif @avatarable.errors[:avatar]
      flash[:error] = @avatarable.errors[:avatar].join(". ")
    else
      flash[:error] = t(:avatar_error, scope: :avatares)
    end
    redirect_to request.referrer || root_path
  end
  
  def destroy
    @avatarable.avatar.purge
    redirect_to request.referrer || root_path
  end
  
  private
  
  def load_avatarable
    @avatarable ||= send Avatares.avatarable_instance
  end

  def model_name
    @avatarable.class.to_s.split("::").last.underscore
  end

  def avatar_params
    params.require(model_name).permit(:avatar, :crop_x, :crop_y, :crop_w, :crop_h)
  end
end
