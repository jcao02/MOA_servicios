class CreateTipoRequisitos < ActiveRecord::Migration
  def change
    create_table :tipo_requisitos do |t|
      t.string :name

      t.timestamps
    end
  end
end
