class AddTramiteToVencidos < ActiveRecord::Migration
  def change
    add_column :vencidos, :tramite_id, :integer
  end
end
