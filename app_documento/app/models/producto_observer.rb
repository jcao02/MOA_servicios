class ProductoObserver < ActiveRecord::Observer
  def after_create(producto)
    producto.registrar_log('Creado')
  end

  def after_update(producto)
    if producto.changed.include? "on"
      tipo = "Visibilidad cambiada"
    else
      tipo = "Actualizado"
    end
    producto.registrar_log(tipo)
  end

  def after_destroy(producto)
    producto.registrar_log('Eliminado')
  end
end
