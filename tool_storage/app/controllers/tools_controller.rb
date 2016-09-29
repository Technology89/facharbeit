class ToolsController < ApplicationController
  require 'barby'
  require 'barby/barcode/ean_8'
  require 'barby/outputter/png_outputter'

  before_action :set_tool, only: [:show, :edit, :update, :destroy]
  before_action :require_signin
  # GET /tools
  # GET /tools.json
  def index
    @tools = Tool.all
  end

  def reorder
    @tools_min = Tool.all.where("lagerbestand < mindestbestand")
  end
  # GET /tools/1
  # GET /tools/1.json
  def show
    @barcode = Barby::EAN8.new(@tool.barcode.to_s)
    File.open('app/assets/images/ean8.png', 'wb'){|f|
      f.write @barcode.to_png(:xdim => 4, :height => 60, :margin => 5)
    }
    Employee.all.each do | employee | 
      indextools = employee.indextools
      indextools.each do | indextool| 
        if indextool.tool_id == @tool.id 
          @employee = employee
          @indextool = indextool
        end 
      end 
    end 
  end

  # GET /tools/new
  def new
    @tool = Tool.new
  end

  # GET /tools/1/edit
  def edit
  end

  # POST /tools
  # POST /tools.json
  def create
    last_entry = Tool.all.order("barcode DESC")
    last_barcode = last_entry.first.barcode
    params[:tool][:barcode] = last_barcode + 1
    params[:tool][:anzahl_ersatz] = 0
    @tool = Tool.new(tool_params)

    respond_to do |format|
      if @tool.save
        format.html { redirect_to @tool, notice: 'Tool was successfully created.' }
        format.json { render :show, status: :created, location: @tool }
      else
        format.html { render :new }
        format.json { render json: @tool.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tools/1
  # PATCH/PUT /tools/1.json
  def update
    respond_to do |format|
      if @tool.update(tool_params)
        format.html { redirect_to @tool, notice: 'Tool was successfully updated.' }
        format.json { render :show, status: :ok, location: @tool }
      else
        format.html { render :edit }
        format.json { render json: @tool.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tools/1
  # DELETE /tools/1.json
  def destroy
    @tool.destroy
    respond_to do |format|
      format.html { redirect_to tools_url, notice: 'Tool was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tool
      @tool = Tool.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tool_params
      params.require(:tool).permit(:hersteller, :modell, :barcode, :lagerbestand, :mindestbestand, :anzahl_ersatz)
    end
end
