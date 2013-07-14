class AddAttsToLogtramite < ActiveRecord::Migration
  def change
    add_column :logtramites, :nusuario, :string
    add_column :logtramites, :nproducto, :string
    add_column :logtramites, :ntipodocumento, :string
  end
end
