Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :articles, except: [:new, :edit]
      resources :comments, except: [:new, :edit]
    end
  end


  resources :articles
  resources :comments
  resource  :dashboard
  resource  :account, :only => [:show] do
    get :work
  end

  get '/login'  => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  root to: 'dashboard#show'
end
