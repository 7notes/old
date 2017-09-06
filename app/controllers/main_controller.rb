class MainController < ApplicationController
	def index
		@title = '7Note'
		render template: 'main/index'
	end
end
