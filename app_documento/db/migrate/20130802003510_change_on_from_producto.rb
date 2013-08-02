class ChangeOnFromProducto < ActiveRecord::Migration
  def up
      change_column :productos, :on, :integer, :default => 1
  end

  def down
      change_column :productos, :on, :integer, :default => nil
  end
end
