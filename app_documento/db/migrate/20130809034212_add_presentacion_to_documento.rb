class AddPresentacionToDocumento < ActiveRecord::Migration
  def change
    add_column :documentos, :presentacion_id, :integer
  end
end
