Rails.application.routes.draw do
  
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/:id/items', to: 'items#index'
      end
      namespace :items do
        get '/:id/merchant', to: 'merchant#show'
      end
      
      resources :merchants, only: [:show, :index]
      resources :items
    end
  end

end
