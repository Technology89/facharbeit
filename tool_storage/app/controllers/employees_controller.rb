class EmployeesController < ApplicationController
before_action :set_employee, only: [:show, :edit, :update, :destroy]
before_action :require_signin
before_action :require_correct_employee, only: [:edit, :update, :destroy]
before_action :set_machines, only: [:show] 
before_action :set_tools, only: [:show] 
  # GET /employees
  # GET /employees.json
  def index
    @employees = Employee.all

  end

  # GET /employees/1
  # GET /employees/1.json
  def show 
    @indextools = @employee.indextools
    @indexmachines = @employee.indexmachines   
  end

 
  # GET /employees/new
  def new
    @employee = Employee.new
  end

  # GET /employees/1/edit
  def edit
  end

  # POST /employees
  # POST /employees.json
  def create
    @employee = Employee.new(employee_params)

    respond_to do |format|
      if @employee.save
        format.html { redirect_to @employee, notice: 'Employee was successfully created.' }
        format.json { render :show, status: :created, location: @employee }
      else
        format.html { render :new }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /employees/1
  # PATCH/PUT /employees/1.json
  def update
    respond_to do |format|
      if @employee.update(employee_params)
        format.html { redirect_to @employee, notice: 'Employee was successfully updated.' }
        format.json { render :show, status: :ok, location: @employee }
      else
        format.html { render :edit }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employees/1
  # DELETE /employees/1.json
  def destroy
    if current_employee.id == @employee.id
      session[:employee_id] = nil
    end
    
    @employee.destroy
    respond_to do |format|
      format.html { redirect_to employees_url, notice: 'Employee was successfully destroyed.' }
      format.json { head :no_content }
    end
    
  end

  private

     def require_correct_employee
      @employee = Employee.find(params[:id])
      unless current_employee == @employee
        redirect_to root_url
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      @employee = Employee.find(params[:id])
    end

    def set_machines
      @machines = Machine.all
    end

    def set_tools
      @tools = Tool.all
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def employee_params
      params.require(:employee).permit(:vorname, :nachname, :personalnummer)
    end
end
