class CreateImportadorsProductosJoinTable < ActiveRecord::Migration
  def up
      create_table :importadors_productos, :id => false do |t|
          t.integer :importador_id
          t.integer :producto_id
      end
  end

  def down
      drop_table :importadors_productos
  end
end
