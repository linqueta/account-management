# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users,
             path: '',
             path_names: {
               sign_in: 'login'
             },
             controllers: {
               sessions: 'sessions'
             }
end
