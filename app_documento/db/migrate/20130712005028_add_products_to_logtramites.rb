class AddProductsToLogtramites < ActiveRecord::Migration
  def change
    add_column :logtramites, :producto_id, :Integer
  end
end
