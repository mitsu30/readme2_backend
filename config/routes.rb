Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :image_texts, only: [:create, :update, :show]
      post '/image_texts/preview', to: 'image_texts#preview'
      get '/wakeup', to: 'image_texts#wakeup'

      resources :users, only: [:update, :show]

      post "/auth", to: "authentications#create"
    end
  end
end
