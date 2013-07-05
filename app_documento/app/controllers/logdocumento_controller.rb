class LogdocumentoController < ApplicationController
  def index
    @logdocumentos = Logdocumento.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @logdocumentos }
    end
  end
end
