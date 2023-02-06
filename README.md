## Overview

Rails gem for Initials Avatars (Gmail style) like those pictured below

<p align="center">
	<img src="https://user-images.githubusercontent.com/138067/52684517-8a70a400-2f14-11e9-8412-04945bc7c839.png" alt="sample">
</p>

Or crop and upload your own pictures.<br />

Works with Vips or imageMagick, whickever you have installed.

## Requirements

#### jQuery and Bootstrap

This is not mandatory but it is needed to edit and upload images.<br />
Otherwise you will work only with the initials avatar.<br />
If they are not installed on your system include them into your headers.

```ruby
gem 'jquery-rails'
gem 'jquery-ui-rails', '>= 4.0.0'
gem 'bootstrap', '~> 4.0'
```

```ruby
//= require jquery3
//= require jquery_ujs
//= require bootstrap
```

#### Vips or ImageMagick

Image analysis and transformation is made with ImageProcessing which depends on Vips or ImageMagick.<br /> 
The gem will use whatever is configured in your ActiveStorage processor.<br>
You can check this by running:

```
irb(main):001:0> Rails.application.config.active_storage.variant_processor
=> :vips
or:
=> :mini_magick
```

If none of them are installed add to your Dockerfile:

```sh
RUN apt-get update -yq \
  && apt-get upgrade -yq \
  && apt-get install -y --no-install-recommends imagemagick libvips42  <---  One of them
```

## Installation

Add to your Gemfile:

```ruby
gem 'avatares', '~> 1.1.0', github: 'MateoLa/avatares'
```

And then execute:

```sh
$ bundle install
$ rails generate avatares:install
```

After installation verify your routes for: `mount Avatares::Engine, at: '/avatares'`

## Settings

### Initializer

Options can be set to change the image size, the default text color or its font. 

```ruby
# app/config/initializer/avatares.rb.

Avatares.setup do |config|
  # Method to get the avatarable in the controller
  config.avatarable_instance = :current_user

  config.size = "350x350"
  config.color = "#FFFFFF"
  config.font = "DejaVu-Sans"
end
```

Avatares assumes that `current_user` can be used to access the avatarable in your controllers. If not, you must provide an alternative method in `config.avatabrable_instance =` (eg. @user).<br />

To use MiniMagick you must also configure one of its allowed fonts. 

#### Choosing Fonts for MiniMagick

Check what fonts you can choose running `$ convert -list font` on your terminal.

Or over docker run:
```sh
docker-compose run --rm "your-app-service" bundle exec convert -list font
```

### Preparing your models

`acts_as_avatarable` and `avatar_string` methods should be added to your avatarable model.

```ruby
class User < ActiveRecord::Base
  acts_as_avatarable

  #Return any string you want to use to generate de "initals" avatar.
  def avatar_string
    return "You should add method :avatar_string in your Avatarable model"
  end  
end
```

The engine will extract at most 3 initials from the passed-in string (e.g. Bill James Pheonix MacKenzie will produce an avatar with the initials BJP).

You are not limited to the User model. You can use "acts_as_avatarable" in any other model or use it in several different models.

### Preparing your views

For rendering an user's avatar:

```ruby
<%= image_tag main_app.url_for(@user.avatar), id: "avataresAvatar" if @user.avatar.attached? %>
```

For rendering the avatar form:

```ruby
<div id="avataresEdit">Edit</div>
<%= render partial: 'avatars/form', object: @user, as: :avatarable %>
```

The form is implemented in a hidden JS PopUp so the `avataresEdit` and `avataresAvatar` IDs cannot be modified and must be present.

To remove your image and return to the default avatar:

```ruby
<%= link_to "Delete", avatares.avatar_path, method: :delete if @user.avatar.attached? && !@user.avatar.filename.sanitized.include?("avatar-") %>
```

## Spree Example

```ruby
module Spree::UserDecorator
  def self.prepended(base)
    base.acts_as_avatarable
  end

  def avatar_string
    self.addresses&.last&.full_name || self.email
  end
end

Spree::User.prepend Spree::UserDecorator
```

```ruby
Deface::Override.new(
  virtual_path: "spree/users/show",
  name: "Add Avatar to Users Show",
  insert_top: "div.account-page > div:first-of-type",
  text: <<-HTML
    <div class="col-xs-12 col-lg-4" data-hook="account-avatar">
      <div>
        <%= image_tag main_app.url_for(@user.avatar), id: "avataresAvatar", size: 200 if @user.avatar.attached? %>
        <div id="avataresEdit" class="text-primary ml-3"> <%= inline_svg_tag('edit.svg', width: 27.6, height: 24) %> </div>​
        <%= link_to inline_svg_tag("garbage_2.svg"), avatares.avatar_path, method: :delete, class: "ml-3" if @user.avatar.attached? && !@user.avatar.filename.sanitized.include?("avatar-") %>
        <%= render partial: 'avatars/form', object: @user, as: :avatarable %>
      </div>
    </div>
  HTML
)
```

For Spree versions ~> 4.4 another option to show the avatar is:

```ruby
<%= image_tag main_app.cdn_image_url(@user.avatar), id: "avataresAvatar", size: 200 if @user.avatar.attached? %>
```

## References

There are many Avatar gems, this one is mainly based on:
* [Muhammad Ebeid](
https://www.muhammadebeid.com/blog/generate-initials-avatar-programmatically-with-minimagick-and-active-storage) blog
* [AvatarMagick](https://github.com/bjedrocha/avatar_magick) plugin
* [Avatar For Rails](https://github.com/ging/avatars_for_rails) plugin

## License

The gem is available as open source under the terms of the [MIT License](./LICENSE).
