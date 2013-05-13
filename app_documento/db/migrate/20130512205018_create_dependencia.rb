class CreateDependencia < ActiveRecord::Migration
  def change
    create_table :dependencia do |t|
      t.integer :TipoDocumento_id
      t.integer :TipoRequisito_id

      t.timestamps
    end
  end
end
