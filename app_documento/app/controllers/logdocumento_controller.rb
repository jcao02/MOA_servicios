class LogdocumentoController < ApplicationController
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
