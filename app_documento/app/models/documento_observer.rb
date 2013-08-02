class DocumentoObserver < ActiveRecord::Observer
  def after_create(documento)
    documento.registrar_log('Creado')
  end

  def after_update(documento)
    documento.registrar_log('Actualizado')
  end

  def after_destroy(documento)
    documento.registrar_log('Eliminado')
  end

end
