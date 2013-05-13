class AddForeignUsuarioToTramite < ActiveRecord::Migration
  def change
      change_table :tramites do |t|
          t.references :usuario
      end
  end
end
