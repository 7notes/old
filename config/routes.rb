Rails.application.routes.draw do
  devise_for :account, controllers: { sessions: 'account/sessions', registrations: 'account/registrations' }
  root 'main#index'
end
