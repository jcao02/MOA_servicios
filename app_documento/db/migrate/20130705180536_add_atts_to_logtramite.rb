class AddAttsToLogtramite < ActiveRecord::Migration
  def change
    add_column :logtramites, :nusuario, :string
    add_column :logtramites, :nproducto, :string
    add_column :logtramites, :ntramite, :string
    add_column :logtramites, :ntipotocumento, :string

  end
end
