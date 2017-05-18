Rails.application.routes.draw do
  get 'repositories/list'
  resources :repositories, only: [:index, :show] do
    post "review_comment", on: :collection
  end

  get 'home/index'
  match "/auth/github/callback", to: 'sessions#create', via: :all
  match "/signout", to: 'sessions#destroy', via: :all
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'
end
