class ChangeTramiteInVencidos < ActiveRecord::Migration
  def up
    rename_column :vencidos, :tramite, :tramitando
  end

  def down
    rename_column :vencidos, :tramitando, :tramite
  end
end
