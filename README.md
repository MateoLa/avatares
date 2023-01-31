## Overview

Rails gem for Initials Avatars (Gmail style) like those pictured below

<p align="center">
	<img src="https://user-images.githubusercontent.com/138067/52684517-8a70a400-2f14-11e9-8412-04945bc7c839.png" alt="sample">
</p>

You can also crop and upload your own images.<br />

## Requirements

ImageMagick command-line tool has to be installed on your system.<br>
You can check if you have it installed by running:

```
$ convert -version
Version: ImageMagick 6.8.9-7 Q16 x86_64 2014-09-11 http://www.imagemagick.org
Copyright: Copyright (C) 1999-2014 ImageMagick Studio LLC
Features: DPC Modules
Delegates: bzlib fftw freetype jng jpeg lcms ltdl lzma png tiff xml zlib
```

Over docker run:
```sh
docker-compose exec "your-app-service" bundle exec convert -version
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

## Settings

### Initializer

Options can be set to change the size of the image, the default text color or its font. 

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

Avatares assumes that `current_user` can be used to access the avatarable in your controllers. If not provide an alternative method in `config.avatabrable_instance =` (eg. @user).

#### Choosing Fonts

To see what fonts can be choosen open up a terminal and type `$ convert -list font`.

Over docker run:
```sh
docker-compose exec "your-app-service" bundle exec convert -list font
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

For rendering an image_tag for an user's avatar:

```ruby
<%= image_tag main_app.url_for(@user.avatar), id: "avataresAvatar" if @user.avatar.attached? %>
```

For rendering the avatar form:

```ruby
<div id="avataresEdit" class="">Edit</div>
<%= render partial: 'avatars/form', object: @user, as: :avatarable %>
```

The form is implemented in a JavaScript PopUp so the `avataresEdit` and `avataresAvatar` IDs cannot be modified and must be used.<br />

For deleting your picture and return to the default avatar:

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
        <div id="avataresEdit" class="d-inline text-primary ml-3">​
          <%= inline_svg_tag('edit.svg', width: 27.6, height: 24) %>
        </div>
        <%= link_to inline_svg_tag("garbage_2.svg", class: "ml-3"), avatares.avatar_path, method: :delete if @user.avatar.attached? && !@user.avatar.filename.sanitized.include?("avatar-") %>
        <%= render partial: 'avatars/form', object: @user, as: :avatarable %>
      </div>
    </div>
  HTML
)
```

You can also use:

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
