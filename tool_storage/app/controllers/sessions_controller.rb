class SessionsController < ApplicationController
	def new

	end

	def create
		if user = User.authenticate(params[:name], params[:password])
			session[:user_id] = user.id
			flash[:notice] = "Hey BOY, back again"
			redirect_to session[:intended_url] || root_path
			session[:intended_url] = nil 
		else
			flash.now[:alert] = "Name nicht gefunden oder falsches Passwort"
			render :new
		end
	end	

	def destroy
		session[:user_id] = nil
		redirect_to root_url, notice: "Bye Bye"
	end
end
