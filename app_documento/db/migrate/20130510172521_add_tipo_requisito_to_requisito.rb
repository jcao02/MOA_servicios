class AddTipoRequisitoToRequisito < ActiveRecord::Migration
  def change
      change_table :requisitos do |t|
          t.references :TipoRequisito
      end
  end
end
