class RemoveUselessFromDocumento < ActiveRecord::Migration
  def up
    remove_column :documentos, :archivo
    remove_column :documentos, :archivo_file_name
    remove_column :documentos, :archivo_content_type
    remove_column :documentos, :archivo_file_size
    remove_column :documentos, :archivo_updated_at
    remove_column :documentos, :tipo
  end

  def down
    add_column :documentos, :tipo, :integer
    add_column :documentos, :archivo_updated_at, :datetime
    add_column :documentos, :archivo_file_size, :integer
    add_column :documentos, :archivo_content_type, :string
    add_column :documentos, :archivo_file_name, :string
    add_column :documentos, :archivo, :string
  end
end
