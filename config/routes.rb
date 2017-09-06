Rails.application.routes.draw do
  devise_for :accounts
  root 'main#index'
end
