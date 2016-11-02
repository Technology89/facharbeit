class EmployeeSessionsController < ApplicationController	
  before_action :require_signin
	def new
	end

	def create
		if employee = Employee.setup(params[:personalnummer])
			session[:employee_id] = employee.id
			session[:time_now] = Time.now.utc
			redirect_to employee_url(employee.id), notice: "Kartei von #{current_employee.vorname} #{current_employee.nachname} geöffnet"
		else
			redirect_to new_employee_session_url, alert: "Personalnummer wurde nicht gefunden"
		end
	end	

	def destroy
		employee = current_employee
		session[:employee_id] = nil
		redirect_to begin_url, notice: "Kartei von #{employee.vorname} #{employee.nachname} geschlossen"
	end
end
