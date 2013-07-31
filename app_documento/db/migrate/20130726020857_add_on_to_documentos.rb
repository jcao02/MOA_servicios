class AddOnToDocumentos < ActiveRecord::Migration
  def change
    add_column :documentos, :on, :integer
  end
end
