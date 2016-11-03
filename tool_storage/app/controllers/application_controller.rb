class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :watch_session_user
  before_action :watch_session_employee
  
  def current_user
  	@current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def require_signin
  	unless current_user
  		session[:intended_url] = request.url
  		redirect_to signin_url
  	end
  end

   def current_employee
    @current_employee ||= Employee.find(session[:employee_id]) if session[:employee_id]
  end
  helper_method :current_employee

  def require_employee
    unless current_employee
      session[:intended_url] = request.url
      redirect_to new_employee_session_url, alert: "Bitte erst eine Werkzeugkartei auswählen"
    end
  end

  def watch_session_user
    if current_user.blank?
    else
      user = current_user
      time = Time.now.utc - session[:time_now_session_user].to_time(:utc)
      if time > 1800       
        session[:employee_id] = nil
        session[:user_id] = nil
        redirect_to signin_url, notice: "Aufgrund von Zeitüberschreitung wurde User #{user.name} abgemeldet"
      else
        session[:time_now_session_user] = Time.now.to_s
      end
    end
  end

  def watch_session_employee
    if current_employee.blank?
    else
      employee = current_employee
      time = Time.now.utc - session[:time_now_session_employee].to_time(:utc)
      if time > 300
        session[:employee_id_session_employee] = nil
        redirect_to new_employee_session_url, notice: "Aufgrund von Zeitüberschreitung wurde die Kartei von #{employee.vorname} #{employee.nachname} geschlossen"
      else
        session[:time_now_session_employee] = Time.now.to_s
      end
    end
  end

end
