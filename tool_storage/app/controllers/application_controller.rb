class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  

  def current_user
  	@current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def require_signin
  	unless current_user
  		session[:intended_url] = request.url
  		redirect_to new_session_url, alert: "Bitte erst Einloggen!"
  	end
  end

   def current_employee
    @current_employee ||= Employee.find(session[:employee_id]) if session[:employee_id]
  end
  helper_method :current_employee

  def require_employee
    unless current_employee
      session[:intended_url] = request.url
      redirect_to new_employee_session_url, alert: "Bitte erst Einloggen!"
    end
  end

end
