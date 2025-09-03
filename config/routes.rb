Rails.application.routes.draw do
  devise_for :users

  root to: 'homes#top'
  get 'home/about', to: 'homes#about', as: 'about'
  
  resources :users, only: [:index, :show, :edit, :update]
  resources :books, only: [:index, :create, :edit, :update, :destroy, :show] do
    resource  :favorite,       only: [:create, :destroy]
    resources :book_comments,  only: [:create, :destroy]
  end
end
