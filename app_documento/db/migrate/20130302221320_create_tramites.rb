class CreateTramites < ActiveRecord::Migration
  def change
    create_table :tramites do |t|
      t.string :codigo_seguimiento
      t.integer :tipo
      t.integer :estado
      t.date :fecha_recepcion
      t.text :observacion

      t.timestamps
    end
  end
end
