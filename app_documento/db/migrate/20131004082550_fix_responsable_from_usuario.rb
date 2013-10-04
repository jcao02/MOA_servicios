class FixResponsableFromUsuario < ActiveRecord::Migration
  def up
    rename_column :clientes, :responsable_id, :usuario_id
  end

  def down
    rename_column :clientes, :usuario_id, :responsable_id
  end
end
