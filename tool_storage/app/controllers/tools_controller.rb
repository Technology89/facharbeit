class ToolsController < ApplicationController
  require 'barby'
  require 'barby/barcode/ean_8'
  require 'barby/outputter/png_outputter'
  before_action :require_signin
  before_action :set_tool, only: [:show, :edit, :update, :destroy]
  
  def index
    @tools = Tool.all.order("hersteller ASC").order("modell ASC").order("barcode ASC")
  end

  def reorder
    @tools_min = Tool.all.where("lagerbestand < mindestbestand").order("hersteller ASC").order("modell ASC")
  end
  
  def show
    @barcode = Barby::EAN8.new(@tool.barcode.to_s)
    File.open('app/assets/images/ean8.png', 'wb'){|f|
      f.write @barcode.to_png(:xdim => 4, :height => 60, :margin => 5)
    }    
  end

  def new
    @tool = Tool.new
  end

  def edit
  end

  def create
    last_entry = Tool.all.order("barcode DESC")
    if last_entry.blank?
      last_barcode = 3354964
    else
      last_barcode = last_entry.first.barcode
    end    
    params[:tool][:hersteller] = params[:tool][:hersteller].capitalize
    params[:tool][:modell] = params[:tool][:modell].capitalize
    params[:tool][:barcode] = last_barcode + 1
    params[:tool][:anzahl_ersatz] = 0
    @tool = Tool.new(tool_params)
    if @tool.save      
      redirect_to tool_url(@tool.id), notice: "#{@tool.hersteller} #{@tool.modell} wurde erfolgreich erstellt"  
    else 
      render :new
    end
  end

  def update
    if @tool.update(tool_params)
      redirect_to tool_url(@tool.id), notice: "#{@tool.hersteller} #{@tool.modell} wurde erfolgreich geändert"  
    else
      render :edit
    end
  end

  def refill
  end

  def save_refill
    tool = Tool.find_by(barcode: params[:barcode])    
    if tool.blank?
      redirect_to refill_url, alert: "Barcode wurde nicht gefunden!"
    else
      tool.lagerbestand = tool.lagerbestand + params[:refill].to_i      
      if tool.save
        redirect_to tools_url, notice: "#{tool.hersteller} #{tool.modell} wurde aufgefüllt"
      else
        redirect_to refill_url, alert: "Artikel konnte nicht aufgefüllt werden!"
      end
    end   
  end
  
  def destroy
    tool = @tool
    @tool.destroy
      redirect_to tools_url, notice: "#{tool.hersteller} #{tool.modell} wurde erfolgreich gelöscht"
  end

  private
    def set_tool
      @tool = Tool.find(params[:id])
    end

    def tool_params
      params.require(:tool).permit(:hersteller, :modell, :barcode, :lagerbestand, :mindestbestand, :anzahl_ersatz)
    end
end
