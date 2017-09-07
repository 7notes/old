Rails.application.routes.draw do
  root 'main#index'
  scope :account do
  	get '/sign_in', to: 'account#sign_in'
  	get '/sign_up', to: 'account#sign_up'
  	post '/sign_in', to: 'account#sign_in'
  	post '/sign_up', to: 'account#sign_up'
  end
end
