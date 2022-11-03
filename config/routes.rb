Avatares::Engine.routes.draw do
  resource :avatar, only: [:edit, :update, :destroy]
end