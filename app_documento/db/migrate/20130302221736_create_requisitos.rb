class CreateRequisitos < ActiveRecord::Migration
  def change
    create_table :requisitos do |t|
      t.integer :id
      t.text :descripcion
      t.text :observacion
      t.integer :estado
      t.references :tramite

      t.timestamps
    end
    add_index :requisitos, :tramite_id
  end
end
