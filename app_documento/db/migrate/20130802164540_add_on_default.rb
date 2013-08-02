class AddOnDefault < ActiveRecord::Migration
  def up
    change_column :documentos, :on, :integer, :default => 1
    change_column :productos, :on, :integer, :default => 1

  end
  def down
    change_column :documentos, :on, :integer, :default => nil
    change_column :productos, :on, :integer, :default => nil
  end
end
