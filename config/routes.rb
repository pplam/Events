Rails.application.routes.draw do
  devise_scope :user do
    authenticated :user do
      root 'teams#index', as: :authenticated_root
    end

    unauthenticated :user do
      root 'users/sessions#new', as: :unauthenticated_root
    end
  end

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

  put 'users/apply_join_team/:team_id', to: 'users#apply_join_team', as: :apply_join_team

  put 'teams/:id/accept_user_join/:user_id', to: 'teams#accept_user_join', as: :accept_user_join

  delete 'teams/:id/remove_team_user/:user_id', to: 'teams#remove_team_user', as: :remove_team_user

  resources :comments
  resources :todos
  resources :accesses
  resources :projects
  resources :users
  resources :teams

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
