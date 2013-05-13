class AddForeignProductoToTramite < ActiveRecord::Migration
  def change
      change_table :tramites do |t|
          t.references :producto
      end
  end
end
