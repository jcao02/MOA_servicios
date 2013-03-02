class CreateDocumentos < ActiveRecord::Migration
  def change
    create_table :documentos do |t|
      t.integer :tipo
      t.date :fecha_vencimiento
      t.boolean :alerta
      t.date :fecha_emision
      t.string :archivo
      t.references :producto

      t.timestamps
    end
    add_index :documentos, :producto_id
  end
end
