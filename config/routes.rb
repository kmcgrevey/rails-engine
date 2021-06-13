Rails.application.routes.draw do
  
  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:show]
    end
  end
  
end
