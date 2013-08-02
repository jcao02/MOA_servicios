class LogtramiteController < ApplicationController
  def index
    @logtramites = Logtramite.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @logtramites }
    end
  end

  def show_by_user
    @logs = Logtramite.where(:tramite_id => params[:id])
  end
end
