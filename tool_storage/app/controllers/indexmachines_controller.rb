class IndexmachinesController < ApplicationController
 
before_action :require_signin
before_action :set_employee
before_action :set_machines
before_action :require_employee, only: [:new]

  def new
    @indexmachine = @employee.indexmachines.new(employee_id: @employee.id, ausgegeben_am: Date.current())
    
  end

  def create
    machine = Machine.find_by(barcode: params[:barcode][0...7])

    if machine == nil
      flash[:alert] = "Barcode nicht gefunden"
      redirect_to new_employee_indexmachine_url(@employee.id)
    else
      if machine.ausgeliehen == false
        params[:indexmachine][:machine_id] = machine.id
        params[:indexmachine][:ausgegeben_von] = @current_user.name
        @indexmachine = @employee.indexmachines.new(indexmachine_params)
        
        if @indexmachine.save
          machine.ausgeliehen = true
          if machine.save
            redirect_to employee_indexmachines_path(@employee.id)
          else
            render :new, notice: "Fehler beim Speichern!"  
          end
        else
          render :new, notice: "Fehler beim Speichern!"  
        end  
      else
        flash[:alert] = "Machine bereits ausgeliehen"
        redirect_to new_employee_indexmachine_url(@employee.id)
     end
    end 
  end

  def destroy
    @indexmachine = Indexmachine.find(params[:id])
    machine = Machine.find_by(id: @indexmachine.machine_id)
    machine.ausgeliehen = false
    machine.save
    @indexmachine.delete
    redirect_to employee_indexmachines_url(@employee.id), notice: "#{Machine.find_by(id: @indexmachine.machine_id).hersteller} #{Machine.find_by(id: @indexmachine.machine_id).modell} erfolgreich gelöscht!"
  end

  private
    def set_employee
      @employee = Employee.find(params[:employee_id])
    end

    def set_machines
      @machines = Machine.all
    end

    def indexmachine_params
      params.require(:indexmachine).permit(:ausgeliehen, :ausgegeben_von,:ausgegeben_am, :employee_id, :machine_id)
    end
end
