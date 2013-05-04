class RemoveProductoFromImportador < ActiveRecord::Migration
  def up
    remove_column :importadors, :producto_id
  end

  def down
    add_column :importadors, :producto_id, :integer
  end
end
