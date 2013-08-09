class LogproductosController < ApplicationController
  before_filter :actualizar_alertas
  before_filter :is_admin
  # GET /logproductos
  # GET /logproductos.json
  def index
    @logproductos = Logproducto.order('created_at DESC').all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @logproductos }
    end
  end

  def show_by_user
    @logs = Logproducto.where(:producto_id => params[:id])
    @usuario = Usuario.find(Producto.find(@logs.first.producto_id).usuario_id)
  end
end
