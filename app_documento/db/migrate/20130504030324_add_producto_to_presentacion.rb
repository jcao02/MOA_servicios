class AddProductoToPresentacion < ActiveRecord::Migration
  def change
      change_table :presentacions do |t|
          t.references :productos
      end
  end
end
