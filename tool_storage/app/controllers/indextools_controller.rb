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
    @indextool = Indextool.new
  end

  # GET /indextools/1/edit
  def edit
  end

  # POST /indextools
  # POST /indextools.json
  def create
    @indextool = Indextool.new(indextool_params)

    respond_to do |format|
      if @indextool.save
        format.html { redirect_to @indextool, notice: 'Indextool was successfully created.' }
        format.json { render :show, status: :created, location: @indextool }
      else
        format.html { render :new }
        format.json { render json: @indextool.errors, status: :unprocessable_entity }
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
      params.require(:indextool).permit(:ausgeliehen, :ausgeliehen_am, :employee_id, :tool_id)
    end
end
