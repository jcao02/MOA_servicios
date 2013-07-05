class LogtramiteController < ApplicationController
  def index
    @logtramites = Logtramite.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @logtramites }
    end
  end
end