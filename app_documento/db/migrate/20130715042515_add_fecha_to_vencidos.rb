class AddFechaToVencidos < ActiveRecord::Migration
  def change
    add_column :vencidos, :fecha, :date
  end
end
