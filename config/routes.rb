# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users,
             path: 'api/v1',
             path_names: {
               sign_in: 'login'
             },
             controllers: {
               sessions: 'sessions'
             }

  namespace :api do
    namespace :v1 do
      resources :accounts, only: :show
    end
  end
end
