class AddAttachmentPdfToDocumentos < ActiveRecord::Migration
  def self.up
    change_table :documentos do |t|
      t.attachment :pdf
    end
  end

  def self.down
    drop_attached_file :documentos, :pdf
  end
end
