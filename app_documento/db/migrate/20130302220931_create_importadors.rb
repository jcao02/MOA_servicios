class CreateImportadors < ActiveRecord::Migration
  def change
    create_table :importadors do |t|
      t.string :rif
      t.string :nombre
      t.string :pais_origen
      t.string :mail
      t.string :telefono

      t.timestamps
    end
  end
end
