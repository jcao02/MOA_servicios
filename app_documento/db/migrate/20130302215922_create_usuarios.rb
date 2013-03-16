class CreateUsuarios < ActiveRecord::Migration
  def change
    create_table :usuarios do |t|
      t.string  :login
      t.string  :telefono
      t.string  :nombre
      t.string  :apellido
      t.string  :compania
      t.string  :rif
      t.integer :admin

      t.timestamps
    end
  end
end
