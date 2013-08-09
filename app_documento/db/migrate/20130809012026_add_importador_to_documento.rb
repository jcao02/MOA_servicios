class AddImportadorToDocumento < ActiveRecord::Migration
  def change
    add_column :documentos, :importador_id, :integer
  end
end
