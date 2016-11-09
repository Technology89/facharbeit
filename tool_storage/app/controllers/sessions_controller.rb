class SessionsController < ApplicationController
	def new

	end

	def create
		if user = User.authenticate(params[:name].capitalize, params[:password])
			session[:user_id] = user.id			
			session[:time_now_session_user] = Time.now.utc
			redirect_to new_employee_session_url
		else			
			redirect_to new_session_url, alert: "Name wurde nicht gefunden oder das Passwort ist falsch"
		end
	end	

	def destroy
		session[:user_id] = nil
		session[:employee_id] = nil
		redirect_to root_url, notice: "Erfolgreich ausgeloggt"
	end
end
