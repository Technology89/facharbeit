class IndexmachinesController < ApplicationController
 
before_action :require_signin
before_action :set_employee
before_action :set_machines

  # GET /indexmachines
  # GET /indexmachines.json
  def index
    @indexmachines = @employee.indexmachines
  end

  # GET /indexmachines/1
  # GET /indexmachines/1.json
  def show
  end

  # GET /indexmachines/new
  def new
    @indexmachine = @employee.indexmachines.new(employee_id: @employee.id, ausgegeben_am: Date.current())
    
  end

  # GET /indexmachines/1/edit
  def edit
  end

  # POST /indexmachines
  # POST /indexmachines.json
  def create
    machine = Machine.find_by(barcode: params[:barcode][0...7])

    if machine == nil
      flash[:alert] = "Barcode nicht gefunden"
      redirect_to new_employee_indexmachine_url(@employee.id)
    else
      if machine.ausgeliehen == false
        params[:indexmachine][:machine_id] = machine.id
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

  # PATCH/PUT /indexmachines/1
  # PATCH/PUT /indexmachines/1.json
  def update
    
  end

  # DELETE /indexmachines/1
  # DELETE /indexmachines/1.json
  def destroy
    @indexmachine = Indexmachine.find(params[:id])
    machine = Machine.find_by(id: @indexmachine.machine_id)
    machine.ausgeliehen = false
    machine.save
    @indexmachine.delete
    redirect_to employee_indexmachines_url(@employee.id), notice: "#{Machine.find_by(id: @indexmachine.machine_id).hersteller} #{Machine.find_by(id: @indexmachine.machine_id).modell} erfolgreich gelöscht!"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      @employee = Employee.find(params[:employee_id])
    end

    def set_machines
      @machines = Machine.all
    end



    # Never trust parameters from the scary internet, only allow the white list through.
    def indexmachine_params
      params.require(:indexmachine).permit(:ausgeliehen, :ausgegeben_am, :employee_id, :machine_id)
    end
end
