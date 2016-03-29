Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :customers, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }

  root 'site#index'

  get '/' => 'site#index'
  get '/about' => 'site#about'
  get '/contact' => 'site#contact'
  resources :books do
    collection do
      get 'category/:category', action: 'category'
    end
    resources :ratings, only: :create
  end

  scope 'cart' do
    get '/' => 'orders#index', as: 'cart'
    post 'add' => 'orders#add'
    post 'change' => 'orders#change_quantity'
    post 'submit' => 'orders#place'
  end

  get '/orders' => 'orders#list'

  resources :checkout
end
