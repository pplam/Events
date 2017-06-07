Rails.application.routes.draw do
  root to: 'todos#index'
  # devise_for :users
  devise_for :users, path: 'auth', path_names: {
    sign_in: 'login',
    sign_out: 'logout'
  }, controllers: {
    sessions: 'users/sessions'
  }, only: :sessions

  devise_for :users, path: 'auth', path_names: {
    sign_up: 'signup'
  }, controllers: {
    registrations: 'users/registrations'
  }, only: :registrations

  devise_for :users, path: 'auth', path_names: {
  }, controllers: {
    passwords: 'users/passwords'
  }, only: :passwords

  resources :comments
  resources :todos
  resources :accesses
  resources :projects
  resources :users
  resources :teams

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
