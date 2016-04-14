Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :customers, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
  mount ShopperEngine::Engine => "/shop"

  root 'site#index'

  get '/about' => 'site#about'
  get '/contact' => 'site#contact'
  resources :books do
    collection do
      get 'category/:category', action: 'category'
    end
    resources :ratings, only: :create
  end

end
