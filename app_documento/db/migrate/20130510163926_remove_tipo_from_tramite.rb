class RemoveTipoFromTramite < ActiveRecord::Migration
  def up
    remove_column :tramites, :tipo
  end

  def down
    add_column :tramites, :tipo, :integer
  end
end
