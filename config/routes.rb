Rails.application.routes.draw do
  resources :comments
  resources :todos
  resources :accesses
  resources :projects
  resources :users
  resources :teams
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
