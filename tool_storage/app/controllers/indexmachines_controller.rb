class IndexmachinesController < ApplicationController
  before_action :set_indexmachine, only: [:show, :edit, :update, :destroy]
before_action :require_signin
before_action :set_employee
  # GET /indexmachines
  # GET /indexmachines.json
  def index
    @indexmachines = @employee.indexmachines
    @machines = Machine.all
  end

  # GET /indexmachines/1
  # GET /indexmachines/1.json
  def show
  end

  # GET /indexmachines/new
  def new
    @indexmachine = Indexmachine.new
    @tool = Tool.new
  end

  # GET /indexmachines/1/edit
  def edit
  end

  # POST /indexmachines
  # POST /indexmachines.json
  def create
    @indexmachine = Indexmachine.new(indexmachine_params)
    

    respond_to do |format|
      if @indexmachine.save
        format.html { redirect_to @indexmachine, notice: 'Indexmachine was successfully created.' }
        format.json { render :show, status: :created, location: @indexmachine }
      else
        format.html { render :new }
        format.json { render json: @indexmachine.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /indexmachines/1
  # PATCH/PUT /indexmachines/1.json
  def update
    respond_to do |format|
      if @indexmachine.update(indexmachine_params)
        format.html { redirect_to @indexmachine, notice: 'Indexmachine was successfully updated.' }
        format.json { render :show, status: :ok, location: @indexmachine }
      else
        format.html { render :edit }
        format.json { render json: @indexmachine.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /indexmachines/1
  # DELETE /indexmachines/1.json
  def destroy
    @indexmachine.destroy
    respond_to do |format|
      format.html { redirect_to indexmachines_url, notice: 'Indexmachine was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      @employee = Employee.find(params[:employee_id])
    end
  

    # Never trust parameters from the scary internet, only allow the white list through.
    def indexmachine_params
      params.require(:indexmachine).permit(:ausgeliehen, :ausgeliehen_am, :employee_id, :machine_id)
    end
end
