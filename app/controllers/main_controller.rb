class MainController < ApplicationController
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
	end

	def index
		@title = '7Note'
		@page_name = 'main'
		render template: 'main/index'
	end
end
