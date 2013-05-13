class FixTipoDocumentoId < ActiveRecord::Migration
  def up
      rename_column :dependencia, :TipoDocumento_id, :tipo_documento_id
      rename_column :dependencia, :TipoRequisito_id, :tipo_requisito_id
  end

  def down
      rename_column :dependencia, :tipo_documento_id, :TipoDocumento_id
      rename_column :dependencia, :tipo_requisito_id, :TipoRequisito_id
  end
end
