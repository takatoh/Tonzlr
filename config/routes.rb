Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :poolings

  resources :pools

  resources :taggings

  resources :tags

  get 'images/file/:id' => 'images#file'
  resources :images

  resources :wallpapers
  get 'wallpapers/sample/:id' => 'wallpapers#sample'
  get 'wallpapers/thumbnail/:id' => 'wallpapers#thumbnail'

  root :to => 'wallpapers#index'

end
