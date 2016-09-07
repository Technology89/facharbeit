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
    @indexmachine = @employee.indexmachines.new
    
  end

  # GET /indexmachines/1/edit
  def edit
  end

  # POST /indexmachines
  # POST /indexmachines.json
  def create
    machine = Machine.find_by(barcode: params[:barcode])
    params[:indexmachine][:machine_id] = machine.id
    @indexmachine = @employee.indexmachines.new(indexmachine_params)
    
    if @indexmachine.save
      redirect_to employee_indexmachines_path(@employee.id)
    else
      render :new, notice: "Fehler beim Speichern!"  
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
      params.require(:indexmachine).permit(:ausgeliehen, :ausgeliehen_am, :employee_id, :machine_id)
    end
end
