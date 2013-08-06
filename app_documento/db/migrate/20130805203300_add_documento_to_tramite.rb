class AddDocumentoToTramite < ActiveRecord::Migration
  def change
    add_column :tramites, :documento, :boolean, :default => false
  end
end
