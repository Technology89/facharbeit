class IndextoolsController < ApplicationController
  before_action :require_signin
  before_action :set_indextool, :set_tool, only: [:remove, :destroy]
  before_action :set_employee
  before_action :require_employee

  def new
    @indextool = @employee.indextools.new(employee_id: @employee.id, ausgegeben_am: Date.current(), ausgegeben_von: current_user.name)
  end

  def create
    tool = Tool.find_by(barcode: params[:barcode][0...7])
    if tool == nil
      redirect_to new_employee_indextool_url(@employee.id), alert: "Barcode nicht gefunden"
    else
      if tool.lagerbestand <= 0
          redirect_to new_employee_indextool_url(@employee.id), alert: "Der Lagerbestand von #{tool.hersteller} #{tool.modell} ist auf 0. Bitte erst auffüllen"
      else  
        a = @employee.indextools.where(tool_id: tool.id)
        if a.blank?
          params[:indextool][:tool_id] = tool.id
          @indextool = Indextool.new(indextool_params)
          if @indextool.save
            tool.lagerbestand -= 1
            tool.save
              redirect_to new_employee_indextool_url(@employee.id), notice: "#{tool.hersteller} #{tool.modell} wurde zur Kartei von #{@employee.vorname} #{@employee.nachname} hinzugefügt"           
          else
            redirect_to new_employee_indextool_url(@employee.id), alert: "Fehler beim Speichern!"  
          end 
        else
          tool.anzahl_ersatz += 1
          tool.lagerbestand -= 1
          tool.save
            redirect_to new_employee_indextool_url(@employee.id), notice: "#{tool.hersteller} #{tool.modell} wurde auf der Kartei von #{@employee.vorname} #{@employee.nachname} als Ersatz eingetragen"
        end      
      end
    end  
  end
  
  def destroy    
    @tool.lagerbestand += 1
    @tool.save
    @indextool.destroy
      redirect_to employee_url(@employee.id), notice: "#{@tool.hersteller} #{@tool.modell} wurde zurückgegeben"    
  end

  def remove 
    @indextool.destroy
      redirect_to employee_url(@employee.id), notice: "#{@tool.hersteller} #{@tool.modell} wurde von Werkzeugkartei entfernt"
  end

  private
    def set_employee
      @employee = Employee.find(params[:employee_id])
    end

    def set_indextool
      @indextool = current_employee.indextools.find(params[:id])
    end

    def set_tool
      @tool = Tool.find_by(id: @indextool.tool_id)
    end

    def indextool_params
      params.require(:indextool).permit(:ausgeliehen, :ausgegeben_am, :employee_id, :tool_id, :ausgegeben_von)
    end
end
