class AddProductoToImportador < ActiveRecord::Migration
  def change
      change_table :importadors do |t|
          t.references :productos
      end
  end
end
