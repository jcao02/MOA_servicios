class AddVisibleToTramite < ActiveRecord::Migration
  def change
    add_column :tramites, :recibido, :boolean, :default => false
  end
end
