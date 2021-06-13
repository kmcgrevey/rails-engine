Rails.application.routes.draw do
  
  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:show, :index]
    end
  end

end
