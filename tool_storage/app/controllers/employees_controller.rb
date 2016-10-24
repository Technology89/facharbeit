class EmployeesController < ApplicationController
before_action :require_signin
before_action :set_employee, only: [:show, :edit, :update, :destroy]

  def index
    @employees = Employee.all.order("nachname ASC").order("vorname ASC")
  end

  def show 
    @indextools = @employee.indextools.order("ausgegeben_am DESC")
    @indexmachines = @employee.indexmachines.order("ausgegeben_am DESC")   
    @machines = Machine.all
    @tools = Tool.all
  end

  def new
    @employee = Employee.new
  end

  def edit
  end

  def create
    @employee = Employee.new(employee_params)
    if @employee.save
      redirect_to employees_url, notice: "#{@employee.vorname} #{@employee.nachname} wurde erfolgreich erstellt" 
    else
      render :new
    end
  end

  def update
      if @employee.update(employee_params)
        redirect_to employees_url, notice: "#{@employee.vorname} #{@employee.nachname} wurde erfolgreich bearbeitet"        
      else
        render :edit
      end    
  end

  def destroy    
    if @employee.indexmachines.blank?
      if @employee.indextools.blank?
        if @current_employee == @employee
          session[:employee_id] = nil
        end
        employee = @employee
        @employee.destroy
        redirect_to employees_url, notice: "#{employee.vorname} #{employee.nachname} wurde erfolgreich entfernt"
      else
        redirect_to employee_url(@employee.id), alert: "Bitte erst alle Werkzeuge von #{@employee.vorname} #{@employee.nachname} aus der Kartei entfernen"
      end
    else
      redirect_to employee_url(@employee.id), alert: "Bitte erst alle Maschinen von #{@employee.vorname} #{@employee.nachname} aus der Kartei entfernen"
    end
  end

  private
    def set_employee
      @employee = Employee.find(params[:id])
    end   

    def employee_params
      params.require(:employee).permit(:vorname, :nachname, :personalnummer)
    end
end
