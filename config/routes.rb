Rails.application.routes.draw do
  root 'gossips#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'team', to: 'static_pages#team'
  get 'contact', to: 'static_pages#contact'

  get 'gossips/city', to: 'gossips#city_gossips', as: 'city_gossips'

  resources :gossips, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    resources :comments, only: [:create, :destroy] # Imbriqués dans les gossips
    resources :likes, only: [:create, :destroy]    # Imbriqués dans les gossips
  end

  resources :users, only: [:new, :create, :show]
end
