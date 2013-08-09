class LogtramiteController < ApplicationController
  before_filter :actualizar_alertas
  before_filter :is_admin
  def index
    @logtramites = Logtramite.order('created_at DESC').all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @logtramites }
    end
  end

  def show_by_user
    @logs = Logtramite.where(:tramite_id => params[:id])
  end
end
