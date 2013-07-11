class CreateVencidos < ActiveRecord::Migration
  def change
    create_table :vencidos do |t|
      t.integer :usuario_id
      t.string :tipo
      t.integer :producto_id
      t.boolean :active, :default => true
      t.boolean :tramite, :default => false

      t.timestamps
    end
  end
end
