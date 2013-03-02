class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.datetime :fecha_hora
      t.text :descripcion
      t.references :usuario

      t.timestamps
    end
    add_index :logs, :usuario_id
  end
end
