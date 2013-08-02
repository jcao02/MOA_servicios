class ProductoObserver < ActiveRecord::Observer
  def after_create(producto)
    producto.registrar_log('Creado')
  end

  def after_update(producto)
    producto.registrar_log('Actualizado')
  end

  def after_destroy(producto)
    producto.registrar_log('Eliminado')
  end
end
