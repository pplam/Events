Rails.application.routes.draw do
  resources :events
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

  put 'projects/:id/admit_user', to: 'projects#admit_user', as: :admit_user
  delete 'projects/:id/remove_access/:user_id', to: 'projects#remove_access', as: :remove_access

  delete 'users/unapply_join_team/:team_id', to: 'users#unapply_join_team', as: :unapply_join_team
  delete 'users/quit_project/:project_id', to: 'users#quit_project', as: :quit_project

  put 'todos/:id/assign_executor', to: 'todos#assign_executor', as: :assign_executor
  put 'todos/:id/finish', to: 'todos#finish', as: :finish_todo
  put 'todos/:id/update_deadline', to: 'todos#update_deadline', as: :update_deadline

  resources :comments
  resources :todos
  resources :accesses
  resources :projects
  resources :users
  resources :teams

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
