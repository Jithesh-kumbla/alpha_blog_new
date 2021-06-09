class SessionsController < ApplicationController

	def new

	end

	def create
		user = User.find_by(email: params[:session][:email])
		if user && user.authenticate(params[:session][:password])
			session[:user_id] = user.id
			flash[:notice] = "Successfully Logged In"
			redirect_to user
		else
			flash.now[:alert] = "Incorrect username and password"
			render 'new'
		end
	end

	def logout
		session[:user_id] = nil
		flash[:notice] = "Logged Out Successfully"
		redirect_to signup_path
	end	
end