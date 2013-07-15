class AddProductsToLogdocumentos < ActiveRecord::Migration
  def change
    add_column :logdocumentos, :producto_id, :Integer
  end
end
