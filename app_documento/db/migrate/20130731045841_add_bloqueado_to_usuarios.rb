class AddBloqueadoToUsuarios < ActiveRecord::Migration
  def change
    add_column :usuarios, :bloqueado, :integer
  end
end
