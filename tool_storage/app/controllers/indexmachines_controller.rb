class IndexmachinesController < ApplicationController 
  before_action :require_signin
  before_action :require_employee, only: [:new]
  before_action :set_employee

  def new
    @indexmachine = @employee.indexmachines.new(employee_id: @employee.id, ausgegeben_am: Date.current())    
  end

  def create
    machine = Machine.find_by(barcode: params[:barcode][0...7])
    if machine == nil
      redirect_to new_employee_indexmachine_url(@employee.id), alert: "Barcode nicht gefunden"
    else
      if machine.ausgegeben == false
        params[:indexmachine][:machine_id] = machine.id
        params[:indexmachine][:ausgegeben_von] = @current_user.name
        @indexmachine = @employee.indexmachines.new(indexmachine_params)        
        if @indexmachine.save
          machine.ausgegeben = true
          if machine.save
            redirect_to employee_path(@employee.id), notice: "#{machine.hersteller} #{machine.modell} wurde zur Kartei von #{@employee.vorname} #{@employee.nachname} hinzugefügt"
          else
            redirect_to new_employee_indexmachine_url(@employee.id), alert: "Fehler beim speichern!"
          end
        else
          redirect_to new_employee_indexmachine_url(@employee.id), alert: "Fehler beim speichern!" 
        end  
      else
        redirect_to new_employee_indexmachine_url(@employee.id), alert: "Maschine bereits ausgegeben"
      end
    end 
  end

  def destroy
    @indexmachine = Indexmachine.find(params[:id])
    machine = Machine.find_by(id: @indexmachine.machine_id)
    machine.ausgegeben = false
    machine.save
    @indexmachine.delete
      redirect_to employee_url(@employee.id), notice: "#{Machine.find_by(id: @indexmachine.machine_id).hersteller} #{Machine.find_by(id: @indexmachine.machine_id).modell} erfolgreich gelöscht!"
  end

  private
    def set_employee
      @employee = Employee.find(params[:employee_id])
    end

    def indexmachine_params
      params.require(:indexmachine).permit(:ausgeliehen, :ausgegeben_von,:ausgegeben_am, :employee_id, :machine_id)
    end
end
