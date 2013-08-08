class LogproductosController < ApplicationController
  # GET /logproductos
  # GET /logproductos.json
  def index
    @logproductos = Logproducto.all

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
