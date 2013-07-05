class AddAttsToLogdocumento < ActiveRecord::Migration
  def change
    add_column :logdocumentos, :nusuario, :string
    add_column :logdocumentos, :nproducto, :string
    add_column :logdocumentos, :ndocumento, :string
  end
end
