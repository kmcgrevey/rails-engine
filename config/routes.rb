Rails.application.routes.draw do
  
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/:id/items', to: 'items#index'
      end
      
      resources :merchants, only: [:show, :index]
      resources :items, only: [:show, :index, :create, :update]
    end
  end

end
