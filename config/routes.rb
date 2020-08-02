Rails.application.routes.draw do
  root 'photos#new'
  get 'photos/index'
  post 'photos/index'
  get 'photos/new'
  post 'photos/new'
  get 'photos/create'
  post 'photos/create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
