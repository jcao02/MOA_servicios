class AddOnToProductos < ActiveRecord::Migration
  def change
    add_column :productos, :on, :integer
  end
end
