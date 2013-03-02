class CreatePresentacions < ActiveRecord::Migration
  def change
    create_table :presentacions do |t|
      t.string :cpe
      t.date :fecha_vencimiento
      t.string :empaque
      t.integer :peso_neto
      t.integer :peso_escurrido

      t.timestamps
    end
  end
end
