class CreateProductos < ActiveRecord::Migration
  def change
    create_table :productos do |t|
      t.string :registro_sanitario
      t.boolean :alimento
      t.string :nombre
      t.string :marca
      t.string :pais_elaboracion
      t.string :fabricante
      t.string :codigo_arancelario

      t.timestamps
    end
  end
end
