class AddTramiteToDocumento < ActiveRecord::Migration
  def change
    add_column :documentos, :tramite, :boolean
  end
end
