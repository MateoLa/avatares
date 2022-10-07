## Overview

Rails gem for Initials Avatars (Gmail style) like those pictured below

<p align="center">
	<img src="https://user-images.githubusercontent.com/138067/52684517-8a70a400-2f14-11e9-8412-04945bc7c839.png" alt="sample">
</p>

The gem is configurable and options can be set to control text color, font, and size.

There are plenty of Avatar gems, this one is mainly based on [Muhammad Ebeid](
https://www.muhammadebeid.com/blog/generate-initials-avatar-programmatically-with-minimagick-and-active-storage) blog and [AvatarMagick](https://github.com/bjedrocha/avatar_magick) plugin. 

## Requirements

ImageMagick command-line tool has to be installed on your system. You can check if you have it installed by running

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
gem 'avatares', github: 'MateoLa/avatares'
```

And then execute:

```sh
$ bundle install
$ rails generate avatares:install
```

## Settings

### Text Color, Font & Size

You can change the default text color, font or size by modifying the initializer /config/initializer/avatares.rb.

```ruby
Avatares.setup do |config|
  config.color = "#FFFFFF"
  config.size = "150x150"
  config.font = "DejaVu-Sans"
end
```

#### Choosing Fonts

To see what fonts are available, open up the terminal and type ```$ convert -list font```. You can select any font listed when configuring.

Over docker run:
```sh
docker-compose exec "your-app-service" bundle exec convert -list font
```

### Preparing your models

In your model:

```ruby
class User < ActiveRecord::Base
  acts_as_avatarable
end
```

You are not limited to the User model. You can use "acts_as_avatarable" in any other model and use it in several different models.

### Model String

Your avatarable model must define the avatar_string method which is used to generate the initials avatar.
The engine will extract at most 3 initials from the passed-in string (e.g. Bill James Pheonix MacKenzie will produce an avatar with the initials BJP).

```ruby
#Returning any kind of string you want for the model
def avatar_string
  return "You should add method :avatar_string in your Avatarable model"
end
```

### Preparing your views

Use in any of your views:

```ruby
<%= image_tag @user.avatar.url if @user.avatar.attached? %>
```

It is possible to upload any picture to the avatarable model.<br>
There are two options for that:<br>
1) Decorate your avatarable controller to ```include Avatares::ControllerHelpers::AvatarParams```
2) In the avatarable controller permit ```:avatar``` and ```:avatar_img_del``` parameters. You also need to modify the update action to allow the picture deletion.

Then add to your model form:

```ruby
<%= f.file_field :avatar, class: "m-3" %>
```

#### Spree example

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
module Spree::UsersControllerDecorator
  Spree::UsersController.include Avatares::ControllerHelpers::AvatarParams
end

Spree::UsersController.prepend Spree::UsersControllerDecorator
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
