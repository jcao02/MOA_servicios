class UsuarioObserver < ActiveRecord::Observer
  def after_create(usuario)
    usuario.registrar_log('Creado')
  end

  def after_update(usuario)
    if usuario.changed.include? "bloqueado"
      tipo = "Actualizado Status Cambiados"
    else
      tipo = "Actualizado"
    end
    usuario.registrar_log(tipo)
  end

  def after_destroy(usuario)
    usuario.registrar_log('Eliminado')
  end
end
