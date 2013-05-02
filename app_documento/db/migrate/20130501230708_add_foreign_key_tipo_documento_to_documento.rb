class AddForeignKeyTipoDocumentoToDocumento < ActiveRecord::Migration
  def change
    change_table :documentos do |d|
      d.references :TipoDocumento
    end
  end
end
