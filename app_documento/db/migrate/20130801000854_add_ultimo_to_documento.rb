class AddUltimoToDocumento < ActiveRecord::Migration
  def change
    add_column :documentos, :ultimo, :boolean, :default => true
  end
end
