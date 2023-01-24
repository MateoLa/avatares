### Works also with vips.
### Update avatar using turbo.

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
