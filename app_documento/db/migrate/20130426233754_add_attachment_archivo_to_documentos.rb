class AddAttachmentArchivoToDocumentos < ActiveRecord::Migration
  def self.up
    change_table :documentos do |t|
      t.attachment :archivo
    end
  end

  def self.down
    drop_attached_file :documentos, :archivo
  end
end
