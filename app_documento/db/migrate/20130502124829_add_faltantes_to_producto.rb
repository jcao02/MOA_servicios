class AddFaltantesToProducto < ActiveRecord::Migration
  def change
    add_column :productos, :grado_alcoholico, :string
    add_column :productos, :zona_venta, :string
  end
end
