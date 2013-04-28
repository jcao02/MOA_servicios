class ForaneaProductoUsuario < ActiveRecord::Migration
  def up
    change_table :productos do |p|
      p.references :usuario
    end
  end

  def down
    change_table :productos do |p|
      p.remove :usuario_id
    end
  end
end
