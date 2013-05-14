class AddVisibleToTramite < ActiveRecord::Migration
  def change
    add_column :tramites, :recibido, :boolean
  end
end
