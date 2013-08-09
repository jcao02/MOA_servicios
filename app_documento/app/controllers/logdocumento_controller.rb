class LogdocumentoController < ApplicationController
  before_filter :actualizar_alertas
  before_filter :is_admin
  def index
    @logdocumentos = Logdocumento.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @logdocumentos }
    end
  end

  def show_by_user
    @logs = Logdocumento.where(:documento_id => params[:id])
  end
end
