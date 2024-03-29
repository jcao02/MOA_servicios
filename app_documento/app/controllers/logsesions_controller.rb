class LogsesionsController < ApplicationController
  before_filter :actualizar_alertas
  before_filter :is_admin
  # GET /logsesions
  # GET /logsesions.json
  def index
    @logsesions = Logsesion.order('created_at DESC').all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @logsesions }
    end
  end

  def show_by_user
    @logs = Logsesion.where(:usuario_id => params[:id])
    @usuario = Usuario.find(params[:id])
  end
end
