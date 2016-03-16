Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :customers

  root 'site#index'

  get '/' => 'site#index'
  get '/about' => 'site#about'
  get '/contact' => 'site#contact'
  resources :books do
    collection do
      get 'category/:category', action: 'category'
    end
  end

  scope 'cart' do
    get '/' => 'order#index', as: 'cart'
    post 'add' => 'order#add'
    post 'change' => 'order#change_quantity'
  end

  resources :checkout
end
