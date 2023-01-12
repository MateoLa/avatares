Avatares::Engine.routes.draw do
  resources :avatar, only: [:edit, :update, :destroy]
end