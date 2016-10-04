class EmployeeSessionsController < ApplicationController
		def new

	end

	def create
		if employee = Employee.setup(params[:personalnummer])
			session[:employee_id] = employee.id
			flash[:notice] = "Werkzeuge für #{employee.vorname} #{employee.nachname}"
			redirect_to employee_url(employee.id)
			session[:intended_url] = nil 
		else
			flash.now[:alert] = "Personalnummer nicht vorhanden"
			render :new
		end
	end	

	def destroy
		session[:employee_id] = nil
		redirect_to root_url, notice: "Bye Bye"
	end
end
