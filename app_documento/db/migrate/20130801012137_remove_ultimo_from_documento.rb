class RemoveUltimoFromDocumento < ActiveRecord::Migration
  def up
      remove_column :documentos, :ultimo
  end

  def down
      add_column :documentos, :ultimo, :default => true
  end
end
