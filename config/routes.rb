Snapshot::Application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :users, :only => [:index, :show]
    end
  end

  devise_for :users,
    :controllers => {
      :omniauth_callbacks => "users/omniauth_callbacks"
    }
  resources :users, :only => [:show] do
    member do
      get 'likes'
    end
  end

  resources :cities, :only => [:index, :show]
  resources :photos, :only => [:index, :show, :create]

  match ":action" => "static#action"

  root :to => "cities#index"
end
