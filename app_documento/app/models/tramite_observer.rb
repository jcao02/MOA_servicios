class TramiteObserver < ActiveRecord::Observer
  def after_create(tramite)
    #creacion de requisitos
    tramite.crear_requisitos
    #loggin
    tramite.registrar_log('Creado')
  end

  def after_update(tramite)
    #loggin
    if tramite.changed.include? "recibido"
      tipo = "Aceptado"
    else
      tipo = "Requisitos actualizados"
    end

    tramite.registrar_log(tipo)
  end

  def after_destroy(tramite)
    #loggin
    tramite.registrar_log('Eliminado')
  end
end
