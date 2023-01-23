class AvatarsController < ApplicationController
  before_action :load_avatarable, on: [:update, :delete]

  def update
    blob = avatar_params[:base64data]
byebug
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
    params.require(model_name).permit(:avatar, :crop_x, :cropo_y, :crop_w, :crop_h)
  end
end



##############
# If params[:item][:photo] is the param from your post you can add
### image = MiniMagick::Image.new(params[:item][:photo].tempfile.path)
### image.resize "250x200>"

#############
# With ImageProcessing::Vips (default in rails7)
### path = params[:game][:photo].tempfile.path
### image = ImageProcessing::Vips.source(path)
### result = image.resize_to_limit!(800, 800)
### params[:game][:photo].tempfile = result

############
# This works, but in my case I had to remove :photo from item_params, apply the logic above,
# then attach the photo with @item.photo.attach(params[:item][:photo]).
