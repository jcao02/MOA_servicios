class InicioController < ApplicationController
  before_filter :authenticate_usuario!
  before_filter :actualizar_alertas

  def index
    if current_usuario.admin > 0 
      @tablader = Tramite.all
    else
      @tablader = Tramite.where(:usuario_id => current_usuario.id)
      @productos = Producto.where(:usuario_id => current_usuario.id)
    end
  end
end
