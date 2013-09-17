class CreateClientes < ActiveRecord::Migration
  def change
    create_table :clientes do |t|
      t.integer :responsable_id
      t.integer :cliente_id

      t.timestamps
    end
  end
end
