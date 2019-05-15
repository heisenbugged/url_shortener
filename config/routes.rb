Rails.application.routes.draw do
  root 'short_urls#new'    
  resource :stats, only: [:show]  
  resources :short_urls, only: [:show, :create]
  namespace :api do
    resources :short_urls, only: [:show, :create]
  end

  # Make sure this route stays at the bottom so that it doesn't 'eat up' other routes.
  get '/:code', to: 'short_urls#redirect', constraints: { code: /[a-z]{5}/ }  
end
