class DocumentoObserver < ActiveRecord::Observer
  def after_create(documento)
    documento.registrar_log('Creado')
  end

  def after_update(documento)
    if documento.changed.include? "on"
      tipo = "Visibilidad cambiada"
    else
      tipo = "Actualizado"
    end
    documento.registrar_log(tipo)
  end

  def after_destroy(documento)
    documento.registrar_log('Eliminado')
  end

end
