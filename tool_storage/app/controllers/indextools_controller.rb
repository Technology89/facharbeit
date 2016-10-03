class IndextoolsController < ApplicationController
  before_action :set_indextool, only: [:show, :edit, :update, :destroy]
before_action :require_signin
before_action :set_employee
before_action :require_employee
  # GET /indextools
  # GET /indextools.json
  def index
    @indextools = @employee.indextools
    @indexmachines = @employee.indexmachines
    @tools = Tool.all
    @machines = Machine.all
  end

  # GET /indextools/1
  # GET /indextools/1.json
  def show
  end

  # GET /indextools/new
  def new
    @indextool = @employee.indextools.new(employee_id: @employee.id, ausgegeben_am: Date.current())
  end

  # GET /indextools/1/edit
  def edit
  end

  # POST /indextools
  # POST /indextools.json
  def create
    tool = Tool.find_by(barcode: params[:barcode][0...7])
     if tool == nil
      flash[:alert] = "Barcode nicht gefunden"
      redirect_to new_employee_indextool_url(@employee.id)
    else
      a = @employee.indextools.where(tool_id: tool.id)

      if a.blank?
        params[:indextool][:ausgegeben_am] = Date.today
        params[:indextool][:tool_id] = tool.id
        params[:indextool][:ausgegeben_von] = @current_user.name
        @indextool = Indextool.new(indextool_params)
        if @indextool.save
          tool.lagerbestand = tool.lagerbestand - 1
          tool.save
              redirect_to new_employee_indextool_path(@employee.id)
            
        else
            render :new, notice: "Fehler beim Speichern!"  
        end 
      else

        tool.anzahl_ersatz = tool.anzahl_ersatz + 1
        tool.lagerbestand = tool.lagerbestand - 1
        tool.save
       redirect_to employee_indextools_path(@employee.id)
      end
      
    end
  end
    

 

  # PATCH/PUT /indextools/1
  # PATCH/PUT /indextools/1.json
  def update
    respond_to do |format|
      if @indextool.update(indextool_params)
        format.html { redirect_to @indextool, notice: 'Indextool was successfully updated.' }
        format.json { render :show, status: :ok, location: @indextool }
      else
        format.html { render :edit }
        format.json { render json: @indextool.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /indextools/1
  # DELETE /indextools/1.json
  def destroy
    @indextool.destroy
    respond_to do |format|
      format.html { redirect_to indextools_url, notice: 'Indextool was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      @employee = Employee.find(params[:employee_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def indextool_params
      params.require(:indextool).permit(:ausgeliehen, :ausgegeben_am, :employee_id, :tool_id, :ausgegeben_von)
    end
end
