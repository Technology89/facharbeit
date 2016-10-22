class MachinesController < ApplicationController
  require 'barby'
  require 'barby/barcode/ean_8'
  require 'barby/outputter/png_outputter'
  before_action :require_signin
  before_action :set_machine, only: [:show, :edit, :update, :destroy]
  
  def index
    @machines = Machine.all
  end

  def overdue
    @machines_overdue = []
    @employees = Employee.all
    @machines = Machine.all
    @employees.each do | employee |
      employee.indexmachines.where(ausgeliehen: true).each do | machine |
        if machine.ausgegeben_am < (Date.today - 21.days)
          @machines_overdue << machine
        end
      end
    end
  end

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

  def new
    @machine = Machine.new
  end

  def edit
  end

  def create
    last_entry = Machine.all.order("barcode DESC")
    last_barcode = last_entry.first.barcode
    params[:machine][:barcode] = last_barcode + 1
    @machine = Machine.new(machine_params)
    if @machine.save
      redirect_to machine_url(@machine.id), notice: "#{@machine.hersteller} #{@machine.modell} wurde erfolgreich erstellt"  
    else
      render :new
    end
  end

  def update
    if @machine.update(machine_params)
      redirect_to machine_url(@machine.id), notice: "#{@machine.hersteller} #{@machine.modell} wurde erfolgreich geändert"  
    else
      render :edit
    end
  end

  def destroy
    @machine.destroy
    redirect_to machines_url, notice: "#{@machine.hersteller} #{@machine.modell} wurde erfolgreich gelöscht"
  end

  private
    def set_machine
      @machine = Machine.find(params[:id])
    end

    def machine_params
      params.require(:machine).permit(:hersteller, :modell, :barcode, :ausgeliehen, :ausgegeben_am)
    end
end
