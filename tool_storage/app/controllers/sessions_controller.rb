class SessionsController < ApplicationController
	def new

	end

	def create
		if user = User.authenticate(params[:name], params[:password])
			session[:user_id] = user.id
			redirect_to new_employee_session_url
		else
			flash.now[:alert] = "Name nicht gefunden oder falsches Passwort"
			render :new
		end
	end	

	def destroy
		session[:user_id] = nil
		session[:employee_id] = nil
		redirect_to root_url, notice: "Erfolgreich ausgeloggt"
	end
end
