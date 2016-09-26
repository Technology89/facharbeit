class MachinesController < ApplicationController
require 'barby'
require 'barby/barcode/ean_8'
require 'barby/outputter/png_outputter'

before_action :set_machine, only: [:show, :edit, :update, :destroy]
before_action :require_signin
  # GET /machines
  # GET /machines.json
  def index
    @machines = Machine.all
  end



  # GET /machines/1
  # GET /machines/1.json   
  def show
  @barcode = Barby::EAN8.new(@machine.barcode.to_s)
  File.open('app/assets/images/ean8.png', 'wb'){|f|
    f.write @barcode.to_png(:xdim => 4, :height => 60, :margin => 5)
  }
  Employee.all.each do | employee | 
    indexmachines = employee.indexmachines 
    indexmachines.each do | indexmachine | 
      if indexmachine.machine_id == @machine.id 
        @employee = employee
        @indexmachine = indexmachine
      end 
    end 
  end 
 
  end

  # GET /machines/new
  def new
    @machine = Machine.new
  end

  # GET /machines/1/edit
  def edit
  end

  # POST /machines
  # POST /machines.json
  def create
    last_entry = Machine.all.order("barcode DESC")
    last_barcode = last_entry.first.barcode
    params[:machine][:barcode] = last_barcode + 1
    @machine = Machine.new(machine_params)

    respond_to do |format|
      if @machine.save
        format.html { redirect_to @machine, notice: 'Machine was successfully created.' }
        format.json { render :show, status: :created, location: @machine }
      else
        format.html { render :new }
        format.json { render json: @machine.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /machines/1
  # PATCH/PUT /machines/1.json
  def update
    respond_to do |format|
      if @machine.update(machine_params)
        format.html { redirect_to @machine, notice: 'Machine was successfully updated.' }
        format.json { render :show, status: :ok, location: @machine }
      else
        format.html { render :edit }
        format.json { render json: @machine.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /machines/1
  # DELETE /machines/1.json
  def destroy
    @machine.destroy
    respond_to do |format|
      format.html { redirect_to machines_url, notice: 'Machine was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_machine
      @machine = Machine.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def machine_params
      params.require(:machine).permit(:hersteller, :modell, :barcode, :ausgeliehen, :ausgegeben_am)
    end
end
