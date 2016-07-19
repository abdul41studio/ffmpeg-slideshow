Rails.application.routes.draw do
  root 'slideshows#index'

  resources :slideshows do
    resources :media, only: [:create, :index]
    delete 'delete_media', to: "media#delete_media"
    get 'slide_show', to: "media#slideshow"
    post 'create_video', to: "media#create_video"
    delete 'delete_all', to: 'media#delete_all'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
