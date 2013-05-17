class InicioController < ApplicationController
  before_filter :authenticate_usuario!

  def index
    if current_usuario.admin > 0 
        @tablader = Tramite.all
    else
      @productos = Producto.where(:usuario_id => current_usuario.id)
    end
  end
end
