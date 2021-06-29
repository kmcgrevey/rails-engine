Rails.application.routes.draw do
  
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/:id/items', to: 'items#index'
        get '/find', to: 'merchant_searcher#show'
        get '/find_all', to: 'merchant_searcher#index'
      end
      namespace :items do
        get '/:id/merchant', to: 'merchant#show'
        get '/find', to: 'item_searcher#show'
        get '/find_all', to: 'item_searcher#index'
      end
      namespace :revenue do
        get '/merchants', to: 'merchant_revenue#index'
      end
      
      resources :merchants, only: [:show, :index]
      resources :items
    end
  end

end
