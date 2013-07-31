class InicioController < ApplicationController
  before_filter :authenticate_usuario!

  def index
    if current_usuario.admin > 0 
      @tablader = Tramite.all
    else
      session[:alerts] = Vencidos.order("fecha").where(:usuario_id => current_usuario.id)
      @tablader = Tramite.where(:usuario_id => current_usuario.id)
      @productos = Producto.where(:usuario_id => current_usuario.id)
    end
  end
end
