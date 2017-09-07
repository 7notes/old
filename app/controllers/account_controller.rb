class AccountController < ApplicationController
	include AccountHelper
	before_action :init_account, :init_controller

	def init_controller
		@response = {
			:error => 1,
			:body => nil,
			:is_auth => @is_auth,
			:current_user => @current_user
		}
		if @is_auth == false
			@response[:error] = 2
		end
		@normalizer = AccountNormalizer.new
	end

	def sign_in
		if request.method == "GET"
			@title = 'Sign in'
			@page_name = 'sign_in'
			render template: 'account/sign_in'
		elsif request.method == "POST"
			account = Account.find_by(username: @normalizer.username(params[:username])) rescue nil
			unless account.nil?
				if account.check_password(params[:password]) == true
					@response[:error] = 0
					@response[:body] = account
					login(account)
				end
			else
				@response[:error] = 2
			end
			render json: @response
		end
	end
	def sign_up
		if request.method == "GET"
			@title = 'Sign up'
			@page_name = 'sign_up'
			render template: 'account/sign_up'
		elsif request.method == "POST"
			ActiveRecord::Base.transaction(isolation: :serializable) do
				begin
					account = Account.new
					account.username = params[:username]
					account.email = params[:email]
					account.password = params[:password]
					account.first_name = params[:first_name]
					account.last_name = params[:last_name]
					account.gender = params[:gender]
					account.language = params[:language]
					account.save!
					
					@response[:error] = 0
					@response[:body] = account
				rescue ActiveRecord::RecordInvalid
					@response[:error] = 3
					@response[:body] = account.errors.messages
				end
			end
			render json: @response
		end
	end
end
