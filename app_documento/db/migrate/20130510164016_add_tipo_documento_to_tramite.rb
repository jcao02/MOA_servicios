class AddTipoDocumentoToTramite < ActiveRecord::Migration
  def change
      change_table :tramites do |t| 
          t.references :TipoDocumento
      end
  end
end
